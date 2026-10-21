import { useEffect, useMemo, useRef, useState } from 'react';
import { useQueryClient } from '@tanstack/react-query';
import { useForm } from 'react-hook-form';
import { Link, useParams } from 'wouter';
import {
  AlertCircle,
  ArrowDown,
  ArrowLeft,
  ArrowUp,
  Check,
  CirclePlus,
  Code,
  Eye,
  FileAudio,
  FileText,
  Film,
  HelpCircle,
  ListOrdered,
  LoaderCircle,
  Pencil,
  Plus,
  Settings,
  Sparkles,
  Trash2,
  UploadCloud,
  X,
} from 'lucide-react';
import {
  getAdminGetCourseOutlineQueryKey,
  getAdminListCoursesQueryKey,
  useAdminCompleteUpload,
  useAdminCreateLesson,
  useAdminCreateModule,
  useAdminCreateUpload,
  useAdminDeleteLesson,
  useAdminDeleteModule,
  useAdminGetCourseOutline,
  useAdminReorderCourse,
  useAdminUpdateCourse,
  useAdminUpdateLesson,
  useAdminUpdateModule,
  useListExams,
} from '@workspace/api-client-react';
import type { AdminLessonSummary, AdminModuleWithLessons, LessonInputType, PublishStatus } from '@workspace/api-client-react';
import { AdminLayout } from '@/components/layouts/AdminLayout';
import { EmptyState, ErrorState, PageSkeleton } from '@/components/shared/DataState';
import { Form } from '@/components/ui/form';
import { parseSbaQuestions, serializeQuestionsToMarkdown, type ParsedQuestion } from '@/components/quiz/parseQuestions';
import { VERIFIED_QUIZ_1_QUESTIONS } from '@/components/quiz/verifiedQuizData';
import { usePageMeta } from '@/lib/usePageMeta';

type EditorKind = 'module' | 'lesson';
type EditorState = { kind: EditorKind; moduleId?: string; module?: AdminModuleWithLessons; lesson?: AdminLessonSummary } | null;
type UploadState = { busy: boolean; error: string; filename: string; progress: number };
interface CourseFormValues { title: string; slug: string; summary: string; description: string; status: PublishStatus; examId: string; isFree: boolean }
interface ModuleFormValues { title: string }
interface LessonFormValues { title: string; slug: string; type: LessonInputType; body: string; durationSeconds: string; isFreePreview: boolean; status: PublishStatus; mediaFile?: FileList }

const lessonTypes: LessonInputType[] = ['quiz', 'article', 'video', 'pdf', 'audio', 'resource'];
const statuses: PublishStatus[] = ['draft', 'published', 'archived'];

function makeSlug(value: string) {
  return value.toLowerCase().trim().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '');
}

function uploadKind(file: File): 'image' | 'video' | 'audio' | 'pdf' | 'file' {
  if (file.type.startsWith('image/')) return 'image';
  if (file.type.startsWith('video/')) return 'video';
  if (file.type.startsWith('audio/')) return 'audio';
  if (file.type === 'application/pdf' || file.name.toLowerCase().endsWith('.pdf')) return 'pdf';
  return 'file';
}

function allowedFile(file: File) {
  return /^(image\/(png|jpeg|webp|gif|avif)|video\/|audio\/|application\/pdf)$/.test(file.type)
    || /\.(pdf|mp4|mov|webm|m4v|mp3|m4a|wav|ogg|aac|png|jpe?g|webp|gif|avif)$/i.test(file.name);
}

function durationLabel(seconds?: number | null) {
  if (!seconds) return 'Duration not set';
  const mins = Math.floor(seconds / 60);
  return mins ? `${mins} min${seconds % 60 ? ` ${seconds % 60} sec` : ''}` : `${seconds} sec`;
}

export default function CourseEditor() {
  const { id = '' } = useParams<{ id: string }>();
  const queryClient = useQueryClient();
  const queryKey = getAdminGetCourseOutlineQueryKey(id);
  const outlineQuery = useAdminGetCourseOutline(id, { query: { queryKey, enabled: !!id } });
  const examsQuery = useListExams();
  const updateCourse = useAdminUpdateCourse();
  const createModule = useAdminCreateModule();
  const updateModule = useAdminUpdateModule();
  const deleteModule = useAdminDeleteModule();
  const createLesson = useAdminCreateLesson();
  const updateLesson = useAdminUpdateLesson();
  const deleteLesson = useAdminDeleteLesson();
  const reorder = useAdminReorderCourse();
  const createUpload = useAdminCreateUpload();
  const completeUpload = useAdminCompleteUpload();
  const courseForm = useForm<CourseFormValues>({ defaultValues: { title: '', slug: '', summary: '', description: '', status: 'draft', examId: '', isFree: false } });
  const moduleForm = useForm<ModuleFormValues>({ defaultValues: { title: '' } });
  const lessonForm = useForm<LessonFormValues>({ defaultValues: { title: '', slug: '', type: 'quiz', body: '', durationSeconds: '', isFreePreview: false, status: 'draft' } });
  const [courseError, setCourseError] = useState('');
  const [notice, setNotice] = useState('');
  const [editor, setEditor] = useState<EditorState>(null);
  const [modalError, setModalError] = useState('');
  const [upload, setUpload] = useState<UploadState>({ busy: false, error: '', filename: '', progress: 0 });
  const [lessonTab, setLessonTab] = useState<'qa' | 'preview' | 'settings'>('qa');
  const [questionsList, setQuestionsList] = useState<ParsedQuestion[]>([]);
  const initializedId = useRef<string | null>(null);
  const outline = outlineQuery.data;
  const modules = useMemo(() => [...(outline?.modules ?? [])].sort((a, b) => a.position - b.position), [outline?.modules]);

  const watchedBody = lessonForm.watch('body') || '';
  const watchedType = lessonForm.watch('type');

  usePageMeta(outline?.course.title ?? 'Course editor', 'Edit course content and publishing details.');

  useEffect(() => {
    if (!outline || initializedId.current === id) return;
    initializedId.current = id;
    const course = outline.course;
    courseForm.reset({
      title: course.title,
      slug: course.slug,
      summary: course.summary ?? '',
      description: outline.description ?? course.description ?? '',
      status: course.status,
      examId: course.examId ?? '',
      isFree: course.isFree,
    });
  }, [outline, id]);

  async function refreshOutline() {
    await queryClient.invalidateQueries({ queryKey });
  }

  async function saveCourse(values: CourseFormValues) {
    setCourseError('');
    try {
      await updateCourse.mutateAsync({
        id,
        data: { title: values.title.trim(), slug: values.slug.trim(), summary: values.summary.trim(), description: values.description, status: values.status, examId: values.examId || null, isFree: values.isFree, position: outline?.course.position },
      });
      await Promise.all([refreshOutline(), queryClient.invalidateQueries({ queryKey: getAdminListCoursesQueryKey() })]);
      setNotice('Course details saved');
      window.setTimeout(() => setNotice(''), 2600);
    } catch {
      setCourseError('Your changes could not be saved. Please review and try again.');
    }
  }

  async function commitModule(values: ModuleFormValues) {
    if (!editor) return;
    const data = { title: values.title.trim(), topicId: editor.module?.topicId ?? null, position: editor.module?.position ?? modules.length };
    setModalError('');
    try {
      if (editor.module) await updateModule.mutateAsync({ id: editor.module.id, data });
      else await createModule.mutateAsync({ courseId: id, data });
      await refreshOutline();
      setEditor(null);
    } catch {
      setModalError('This module could not be saved. Please try again.');
    }
  }

  async function commitLesson(values: LessonFormValues) {
    if (!editor?.moduleId) return;
    const titleValue = values.title.trim();
    const existing = editor.lesson;

    // If in visual QA mode and questions exist, ensure body is freshly serialized
    let bodyValue = values.body.trim();
    if (questionsList.length > 0) {
      bodyValue = serializeQuestionsToMarkdown(titleValue, questionsList);
    }

    const durationRaw = values.durationSeconds.trim();
    const data = {
      title: titleValue,
      slug: (values.slug || makeSlug(titleValue)).trim(),
      type: values.type,
      body: bodyValue || null,
      assetId: existing?.assetId ?? null,
      durationSeconds: durationRaw ? Number(durationRaw) : null,
      isFreePreview: values.isFreePreview,
      position: existing?.position ?? (modules.find((module) => module.id === editor.moduleId)?.lessons.length ?? 0),
      status: values.status,
    };
    setModalError('');
    try {
      if (existing) await updateLesson.mutateAsync({ id: existing.id, data });
      else await createLesson.mutateAsync({ moduleId: editor.moduleId, data });
      await refreshOutline();
      setEditor(null);
    } catch {
      setModalError('This lesson could not be saved. Please try again.');
    }
  }

  async function uploadFile(file?: File) {
    if (!file || !editor?.lesson) return;
    if (!allowedFile(file)) {
      setUpload((current) => ({ ...current, error: 'Choose a PDF, video, audio file or common image format.' }));
      return;
    }
    setUpload({ busy: true, error: '', filename: file.name, progress: 8 });
    try {
      const target = await createUpload.mutateAsync({ data: { filename: file.name, mimeType: file.type || 'application/octet-stream', sizeBytes: file.size, kind: uploadKind(file) } });
      setUpload((current) => ({ ...current, progress: 28 }));
      const response = await fetch(target.uploadUrl, { method: 'PUT', headers: { 'Content-Type': file.type || 'application/octet-stream' }, body: file });
      if (!response.ok) throw new Error(`Upload failed (${response.status})`);
      setUpload((current) => ({ ...current, progress: 75 }));
      const asset = await completeUpload.mutateAsync({ id: target.assetId });
      const updated = { ...editor.lesson, assetId: asset.id, assetFilename: asset.filename };
      setEditor({ ...editor, lesson: updated });
      await updateLesson.mutateAsync({ id: editor.lesson.id, data: {
        slug: editor.lesson.slug, title: editor.lesson.title, type: editor.lesson.type, body: editor.lesson.body,
        assetId: asset.id, durationSeconds: editor.lesson.durationSeconds ?? null,
        isFreePreview: editor.lesson.isFreePreview, position: editor.lesson.position, status: editor.lesson.status,
      } });
      await refreshOutline();
      setUpload({ busy: false, error: '', filename: asset.filename, progress: 100 });
    } catch (cause) {
      setUpload((current) => ({ ...current, busy: false, progress: 0, error: cause instanceof Error ? cause.message : 'Upload did not complete. Please try again.' }));
    }
  }

  async function removeModule(module: AdminModuleWithLessons) {
    if (!window.confirm(`Delete “${module.title}” and its ${module.lessons.length} lessons? This content will be hidden from learners. Learner progress and notes will be retained.`)) return;
    try {
      await deleteModule.mutateAsync({ id: module.id });
      await refreshOutline();
    } catch { setCourseError('The module could not be deleted. Please try again.'); }
  }

  async function removeLesson(lesson: AdminLessonSummary) {
    if (!window.confirm(`Delete “${lesson.title}”? This lesson will be hidden from learners. Learner progress and notes will be retained.`)) return;
    try {
      await deleteLesson.mutateAsync({ id: lesson.id });
      await refreshOutline();
    } catch { setCourseError('The lesson could not be deleted. Please try again.'); }
  }

  async function moveModule(index: number, delta: number) {
    const target = index + delta;
    if (target < 0 || target >= modules.length) return;
    const next = [...modules];
    [next[index], next[target]] = [next[target], next[index]];
    try {
      await reorder.mutateAsync({ courseId: id, data: { moduleIds: next.map((item) => item.id) } });
      await refreshOutline();
    } catch { setCourseError('Module order could not be updated.'); }
  }

  async function moveLesson(module: AdminModuleWithLessons, index: number, delta: number) {
    const lessons = [...module.lessons].sort((a, b) => a.position - b.position);
    const target = index + delta;
    if (target < 0 || target >= lessons.length) return;
    [lessons[index], lessons[target]] = [lessons[target], lessons[index]];
    try {
      await reorder.mutateAsync({ courseId: id, data: { lessonOrder: { [module.id]: lessons.map((item) => item.id) } } });
      await refreshOutline();
    } catch { setCourseError('Lesson order could not be updated.'); }
  }

  // ─── Visual Q&A Operations ───────────────────────────────────────────────

  function syncQuestionsToForm(qs: ParsedQuestion[]) {
    const title = lessonForm.getValues('title') || 'Quiz';
    const md = serializeQuestionsToMarkdown(title, qs);
    lessonForm.setValue('body', md, { shouldDirty: true });
  }

  function updateQuestionStem(index: number, newStem: string) {
    const updated = [...questionsList];
    updated[index] = { ...updated[index], stem: newStem };
    setQuestionsList(updated);
    syncQuestionsToForm(updated);
  }

  function updateQuestionOption(index: number, optIndex: number, newText: string) {
    const updated = [...questionsList];
    const newOptions = [...updated[index].options];
    newOptions[optIndex] = { ...newOptions[optIndex], text: newText };
    updated[index] = { ...updated[index], options: newOptions };
    setQuestionsList(updated);
    syncQuestionsToForm(updated);
  }

  function setQuestionCorrectKey(index: number, correctKey: string) {
    const updated = [...questionsList];
    updated[index] = { ...updated[index], correctKey };
    setQuestionsList(updated);
    syncQuestionsToForm(updated);
  }

  function updateQuestionExplanation(index: number, newExplanation: string) {
    const updated = [...questionsList];
    updated[index] = { ...updated[index], explanation: newExplanation };
    setQuestionsList(updated);
    syncQuestionsToForm(updated);
  }

  function addNewQuestion() {
    const nextNum = questionsList.length + 1;
    const newQ: ParsedQuestion = {
      id: `q-${Date.now()}`,
      questionNumber: nextNum,
      stem: '',
      options: [
        { key: 'A', text: '' },
        { key: 'B', text: '' },
        { key: 'C', text: '' },
        { key: 'D', text: '' },
        { key: 'E', text: '' },
      ],
      correctKey: 'A',
      explanation: '',
    };
    const updated = [...questionsList, newQ];
    setQuestionsList(updated);
    syncQuestionsToForm(updated);
  }

  function removeQuestion(index: number) {
    if (!window.confirm(`Are you sure you want to delete Question ${index + 1}?`)) return;
    const updated = questionsList.filter((_, idx) => idx !== index).map((q, idx) => ({ ...q, questionNumber: idx + 1 }));
    setQuestionsList(updated);
    syncQuestionsToForm(updated);
  }

  function moveQuestion(index: number, delta: number) {
    const target = index + delta;
    if (target < 0 || target >= questionsList.length) return;
    const updated = [...questionsList];
    [updated[index], updated[target]] = [updated[target], updated[index]];
    const renumbered = updated.map((q, idx) => ({ ...q, questionNumber: idx + 1 }));
    setQuestionsList(renumbered);
    syncQuestionsToForm(renumbered);
  }

  function loadVerifiedQuiz1() {
    if (window.confirm('Replace current quiz content with the 15 officially verified questions for Quiz 1?')) {
      setQuestionsList(VERIFIED_QUIZ_1_QUESTIONS);
      syncQuestionsToForm(VERIFIED_QUIZ_1_QUESTIONS);
    }
  }

  function handleTabChange(tab: 'qa' | 'preview' | 'settings') {
    if (tab === 'qa' && lessonTab === 'settings') {
      const currentBody = lessonForm.getValues('body') || '';
      const parsed = parseSbaQuestions(currentBody);
      if (parsed.questions.length > 0) {
        setQuestionsList(parsed.questions);
      }
    }
    setLessonTab(tab);
  }

  const isSaving = updateCourse.isPending;
  const isModalSaving = createModule.isPending || updateModule.isPending || createLesson.isPending || updateLesson.isPending;
  const mediaFileField = lessonForm.register('mediaFile');

  function openModule(module?: AdminModuleWithLessons) {
    moduleForm.reset({ title: module?.title ?? '' });
    setModalError('');
    setEditor({ kind: 'module', ...(module ? { module } : {}) });
  }

  function openLesson(moduleId: string, lesson?: AdminLessonSummary) {
    const rawBody = lesson?.body ?? '';
    const parsed = parseSbaQuestions(rawBody);
    setQuestionsList(parsed.questions);

    // If this is quiz-1 and it had the old scrambled questions or no questions, offer easy start
    if (lesson?.slug === 'quiz-1' && parsed.questions.length === 0) {
      setQuestionsList(VERIFIED_QUIZ_1_QUESTIONS);
    }

    if (lesson?.type === 'quiz' || parsed.questions.length > 0 || /quiz|sba|mock|paper/i.test(`${lesson?.title || ''} ${lesson?.slug || ''}`)) {
      setLessonTab('qa');
    } else {
      setLessonTab('settings');
    }

    lessonForm.reset({
      title: lesson?.title ?? '',
      slug: lesson?.slug ?? '',
      type: lesson?.type ?? 'quiz',
      body: rawBody,
      durationSeconds: lesson?.durationSeconds?.toString() ?? '',
      isFreePreview: lesson?.isFreePreview ?? false,
      status: lesson?.status ?? 'published',
    });
    setUpload({ busy: false, error: '', filename: lesson?.assetFilename ?? '', progress: 0 });
    setModalError('');
    setEditor({ kind: 'lesson', moduleId, ...(lesson ? { lesson } : {}) });
  }

  return <AdminLayout>
    <div className="course-admin course-editor">
      <div className="editor-crumb"><Link href="/admin"><ArrowLeft size={15} /> All courses</Link><span>/</span><span>{outline?.course.title ?? 'Course editor'}</span></div>
      {outlineQuery.isLoading ? <PageSkeleton rows={4} label="Loading course editor" /> : outlineQuery.isError ? <ErrorState title="This course could not be opened" onRetry={() => void outlineQuery.refetch()} /> : outline ? <>
        <header className="admin-page-head editor-page-head">
          <div><span className="admin-kicker">COURSE EDITOR <span className={`status-pill status-${outline.course.status}`}>{outline.course.status}</span></span><h1>{outline.course.title}</h1><p>Arrange your teaching into a clear path from first principles to exam day.</p></div>
          <div className="editor-top-meta"><span><strong>{outline.course.lessonCount}</strong> lessons</span><span className="editor-meta-rule" /><span>{modules.length} modules</span></div>
        </header>
        <div className="editor-layout">
          <Form {...courseForm}><form className="editor-card course-details-card" onSubmit={courseForm.handleSubmit(saveCourse)}>
            <div className="editor-section-head"><div><span className="admin-kicker">01 · COURSE DETAILS</span><h2>Course identity</h2></div><span className="small-caption">Changes are not public until published</span></div>
            <label className="admin-field">Course title<input required {...courseForm.register('title', { required: true })} data-testid="input-edit-course-title" /></label>
            <div className="field-pair"><label className="admin-field">Slug<input required pattern="[a-z0-9-]+" {...courseForm.register('slug', { required: true, pattern: /^[a-z0-9-]+$/ })} data-testid="input-edit-course-slug" /></label>
              <label className="admin-field">Exam association<select {...courseForm.register('examId')} data-testid="select-course-exam"><option value="">No exam association</option>{examsQuery.data?.items.map((exam) => <option key={exam.id} value={exam.id}>{exam.shortName || exam.name}</option>)}</select></label></div>
            <label className="admin-field">Short summary<textarea rows={2} {...courseForm.register('summary')} placeholder="A concise introduction for the course catalogue" data-testid="input-edit-course-summary" /></label>
            <label className="admin-field">Full description<textarea rows={5} {...courseForm.register('description')} placeholder="What learners will cover and how this course supports their preparation" data-testid="input-edit-course-description" /></label>
            <div className="field-pair course-options"><label className="admin-field">Visibility<select {...courseForm.register('status')} data-testid="select-course-status">{statuses.map((status) => <option value={status} key={status}>{status[0].toUpperCase() + status.slice(1)}</option>)}</select></label>
              <label className="check-field"><input type="checkbox" {...courseForm.register('isFree')} data-testid="checkbox-course-free" /><span><strong>Free course</strong><small>Available without a paid entitlement</small></span></label></div>
            {courseError && <div className="admin-inline-error" role="alert">{courseError}<button type="button" onClick={() => setCourseError('')}>Dismiss</button></div>}
            <div className="save-course-row"><span className="save-feedback" aria-live="polite">{notice && <><Check size={15} /> {notice}</>}</span><button type="submit" className="admin-button admin-button-primary" disabled={isSaving} data-testid="button-save-course">{isSaving ? 'Saving…' : 'Save details'}</button></div>
          </form></Form>

          <section className="curriculum-section">
            <div className="editor-section-head curriculum-heading"><div><span className="admin-kicker">02 · LEARNING PATH</span><h2>Modules & lessons</h2></div><button className="admin-button admin-button-outline" type="button" onClick={() => openModule()} data-testid="button-add-module"><CirclePlus size={16} /> Add module</button></div>
            {modules.length === 0 ? <div className="curriculum-empty"><EmptyState title="No modules yet" text="Add the first module, then build it out with lessons." /><button type="button" className="admin-button admin-button-primary" onClick={() => openModule()}><Plus size={16} /> Add first module</button></div> : <div className="module-stack">{modules.map((module, index) => <article className="module-card-admin" key={module.id} data-testid={`module-${module.id}`}>
              <div className="module-heading-admin">
                <span className="module-index">{String(index + 1).padStart(2, '0')}</span>
                <div className="module-title-wrap"><h3>{module.title}</h3><small>{module.lessons.length} {module.lessons.length === 1 ? 'lesson' : 'lessons'}</small></div>
                <div className="item-actions"><button type="button" className="icon-button" aria-label={`Move ${module.title} up`} disabled={index === 0 || reorder.isPending} onClick={() => void moveModule(index, -1)}><ArrowUp size={15} /></button><button type="button" className="icon-button" aria-label={`Move ${module.title} down`} disabled={index === modules.length - 1 || reorder.isPending} onClick={() => void moveModule(index, 1)}><ArrowDown size={15} /></button><button type="button" className="icon-button" aria-label={`Edit ${module.title}`} onClick={() => openModule(module)}><Pencil size={15} /></button><button type="button" className="icon-button danger-button" aria-label={`Delete ${module.title}`} onClick={() => void removeModule(module)}><Trash2 size={15} /></button></div>
              </div>
              <div className="lesson-list">{[...module.lessons].sort((a, b) => a.position - b.position).map((lesson, lessonIndex) => <div className="lesson-row" key={lesson.id} data-testid={`lesson-${lesson.id}`}>
                <span className={`lesson-type-icon type-${lesson.type}`}>{lesson.type === 'video' ? <Film size={15} /> : lesson.type === 'audio' ? <FileAudio size={15} /> : <FileText size={15} />}</span>
                <button type="button" className="lesson-title-button" onClick={() => openLesson(module.id, lesson)}><strong>{lesson.title}</strong><span>{lesson.type} <i /> {durationLabel(lesson.durationSeconds)}{lesson.assetFilename && <><i /> {lesson.assetFilename}</>}</span></button>
                <span className={`status-pill status-${lesson.status}`}>{lesson.status}</span>
                <div className="lesson-actions"><button type="button" className="icon-button" disabled={lessonIndex === 0 || reorder.isPending} aria-label={`Move ${lesson.title} up`} onClick={() => void moveLesson(module, lessonIndex, -1)}><ArrowUp size={14} /></button><button type="button" className="icon-button" disabled={lessonIndex === module.lessons.length - 1 || reorder.isPending} aria-label={`Move ${lesson.title} down`} onClick={() => void moveLesson(module, lessonIndex, 1)}><ArrowDown size={14} /></button><button type="button" className="icon-button danger-button" aria-label={`Delete ${lesson.title}`} onClick={() => void removeLesson(lesson)}><Trash2 size={14} /></button></div>
              </div>)}</div>
              <button className="add-lesson-button" type="button" onClick={() => openLesson(module.id)}><Plus size={15} /> Add lesson to this module</button>
            </article>)}</div>}
          </section>
        </div>
      </> : null}
    </div>
    {editor && <div className="admin-modal-backdrop" role="presentation" onMouseDown={(event) => { if (event.target === event.currentTarget && !upload.busy) setEditor(null); }}>
      <section className={`admin-dialog editor-dialog ${editor.kind === 'lesson' ? 'editor-dialog-wide' : ''}`} role="dialog" aria-modal="true" aria-labelledby="content-editor-title">
        <div className="dialog-heading"><div><span className="admin-kicker">{editor.kind === 'module' ? 'LEARNING PATH' : 'LESSON CONTENT'}</span><h2 id="content-editor-title">{editor.kind === 'module' ? (editor.module ? 'Edit module' : 'Add a module') : (editor.lesson ? 'Edit lesson' : 'Add a lesson')}</h2></div><button type="button" className="icon-button" onClick={() => setEditor(null)} disabled={upload.busy} aria-label="Close"><X size={19} /></button></div>
        {editor.kind === 'module' ? <Form {...moduleForm}><form onSubmit={moduleForm.handleSubmit(commitModule)}>
          <label className="admin-field">Module title<input autoFocus required {...moduleForm.register('title', { required: true })} placeholder="For example, Approach to acute presentations" data-testid="input-module-title" /></label>
          {modalError && <p className="admin-form-error" role="alert">{modalError}</p>}
          <div className="dialog-actions"><button type="button" className="admin-button admin-button-quiet" onClick={() => setEditor(null)}>Cancel</button><button type="submit" className="admin-button admin-button-primary" disabled={isModalSaving}>{isModalSaving ? 'Saving…' : editor.module ? 'Save module' : 'Create module'}</button></div>
        </form></Form> : <Form {...lessonForm}><form onSubmit={lessonForm.handleSubmit(commitLesson)}>
          <div className="lesson-modal-tabs">
            <button
              type="button"
              className={`lesson-modal-tab ${lessonTab === 'qa' ? 'active' : ''}`}
              onClick={() => handleTabChange('qa')}
            >
              <ListOrdered size={16} /> Q&amp;A Editor
              {questionsList.length > 0 && (
                <span style={{ background: '#0d9488', color: '#fff', fontSize: '0.72rem', padding: '1px 7px', borderRadius: '10px', marginLeft: 4, fontWeight: 800 }}>
                  {questionsList.length} questions
                </span>
              )}
            </button>
            <button
              type="button"
              className={`lesson-modal-tab ${lessonTab === 'preview' ? 'active' : ''}`}
              onClick={() => handleTabChange('preview')}
            >
              <Eye size={16} /> Live Preview
            </button>
            <button
              type="button"
              className={`lesson-modal-tab ${lessonTab === 'settings' ? 'active' : ''}`}
              onClick={() => handleTabChange('settings')}
            >
              <Settings size={16} /> Lesson Settings &amp; Markdown
            </button>
          </div>

          {/* ─── TAB 1: DEDICATED VISUAL Q&A EDITOR ─── */}
          {lessonTab === 'qa' && (
            <div className="editor-dialog-scrollable">
              <div style={{ display: 'flex', flexWrap: 'wrap', alignItems: 'center', justifyContent: 'space-between', gap: 10, padding: '10px 14px', background: '#f8fafc', border: '1px solid #e2e8f0', borderRadius: 8, marginBottom: 14 }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                  <Sparkles size={16} style={{ color: '#0d9488' }} />
                  <strong style={{ fontSize: '0.86rem', color: '#0f172a' }}>Interactive Question &amp; Options Editor:</strong>
                  <span style={{ fontSize: '0.8rem', color: '#059669', background: '#ecfdf5', padding: '2px 8px', borderRadius: 6, fontWeight: 700 }}>
                    {questionsList.length} questions ready
                  </span>
                </div>
                <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                  {editor.lesson?.slug === 'quiz-1' && (
                    <button
                      type="button"
                      className="admin-button admin-button-outline"
                      style={{ padding: '5px 11px', fontSize: '0.76rem', borderColor: '#0d9488', color: '#0f766e', fontWeight: 700 }}
                      onClick={loadVerifiedQuiz1}
                    >
                      ✨ Restore 15 Verified Questions for Quiz 1
                    </button>
                  )}
                  <button
                    type="button"
                    className="admin-button admin-button-primary"
                    style={{ padding: '5px 12px', fontSize: '0.76rem' }}
                    onClick={addNewQuestion}
                  >
                    <Plus size={14} /> Add Question
                  </button>
                </div>
              </div>

              {questionsList.length === 0 ? (
                <div style={{ padding: '36px 20px', textAlign: 'center', background: '#f8fafc', border: '1px dashed #cbd5e1', borderRadius: 10 }}>
                  <AlertCircle size={36} style={{ color: '#d97706', margin: '0 auto 12px' }} />
                  <h3 style={{ margin: '0 0 6px', color: '#1e293b' }}>No questions added yet</h3>
                  <p style={{ margin: '0 0 16px', color: '#64748b', fontSize: '0.85rem' }}>
                    Start by adding your first clinical question or restore verified questions with one click.
                  </p>
                  <div style={{ display: 'flex', justifyContent: 'center', gap: 10 }}>
                    <button type="button" className="admin-button admin-button-primary" onClick={addNewQuestion}>
                      <Plus size={15} /> Add Clinical Question
                    </button>
                    {editor.lesson?.slug === 'quiz-1' && (
                      <button type="button" className="admin-button admin-button-outline" onClick={loadVerifiedQuiz1}>
                        ✨ Load 15 Verified Questions for Quiz 1
                      </button>
                    )}
                  </div>
                </div>
              ) : (
                <div className="qa-editor-list">
                  {questionsList.map((q, qIndex) => (
                    <div key={q.id || qIndex} className="qa-editor-card">
                      <div className="qa-card-top">
                        <div className="qa-card-badge">
                          <span style={{ width: 26, height: 26, borderRadius: '50%', background: '#0d9488', color: '#fff', display: 'grid', placeItems: 'center', fontSize: '0.82rem', fontWeight: 800 }}>
                            {qIndex + 1}
                          </span>
                          <span>Question {qIndex + 1} of {questionsList.length}</span>
                        </div>
                        <div className="qa-card-actions">
                          <button
                            type="button"
                            className="icon-button"
                            disabled={qIndex === 0}
                            onClick={() => moveQuestion(qIndex, -1)}
                            title="Move up"
                          >
                            <ArrowUp size={14} />
                          </button>
                          <button
                            type="button"
                            className="icon-button"
                            disabled={qIndex === questionsList.length - 1}
                            onClick={() => moveQuestion(qIndex, 1)}
                            title="Move down"
                          >
                            <ArrowDown size={14} />
                          </button>
                          <button
                            type="button"
                            className="icon-button danger-button"
                            onClick={() => removeQuestion(qIndex)}
                            title="Delete this question"
                          >
                            <Trash2 size={14} />
                          </button>
                        </div>
                      </div>

                      {/* Question Stem */}
                      <div style={{ marginBottom: 12 }}>
                        <label style={{ display: 'block', fontSize: '0.82rem', fontWeight: 700, color: '#334155', marginBottom: 5 }}>
                          Clinical Scenario &amp; Question Stem:
                        </label>
                        <textarea
                          className="qa-stem-box"
                          value={q.stem}
                          rows={3}
                          placeholder="Enter the clinical scenario and question stem here..."
                          onChange={(e) => updateQuestionStem(qIndex, e.target.value)}
                        />
                      </div>

                      {/* Options A to E */}
                      <div style={{ marginBottom: 14 }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 6 }}>
                          <label style={{ fontSize: '0.82rem', fontWeight: 700, color: '#334155' }}>
                            Options A to E (Click the circle to select the correct answer):
                          </label>
                          <span style={{ fontSize: '0.74rem', color: '#64748b' }}>
                            Correct Answer Selected: <strong style={{ color: '#059669' }}>{q.correctKey}</strong>
                          </span>
                        </div>

                        <div className="qa-options-container">
                          {(q.options || []).map((opt, optIndex) => {
                            const isCorrect = opt.key.toUpperCase() === q.correctKey?.toUpperCase();
                            return (
                              <div key={opt.key} className={`qa-option-row ${isCorrect ? 'is-correct' : ''}`}>
                                <button
                                  type="button"
                                  className={`qa-opt-radio-btn ${isCorrect ? 'is-active' : ''}`}
                                  onClick={() => setQuestionCorrectKey(qIndex, opt.key)}
                                  title={isCorrect ? 'This is the correct answer' : `Set ${opt.key} as the correct answer`}
                                >
                                  {isCorrect && <Check size={14} strokeWidth={3} />}
                                </button>
                                <span className="qa-opt-letter">{opt.key}.</span>
                                <input
                                  type="text"
                                  className="qa-opt-input"
                                  value={opt.text}
                                  placeholder={`Option ${opt.key} text...`}
                                  onChange={(e) => updateQuestionOption(qIndex, optIndex, e.target.value)}
                                />
                                {isCorrect && <span className="qa-opt-tag">✓ Correct Answer</span>}
                              </div>
                            );
                          })}
                        </div>
                      </div>

                      {/* Explanation */}
                      <div>
                        <label style={{ display: 'block', fontSize: '0.82rem', fontWeight: 700, color: '#0d9488', marginBottom: 5 }}>
                          Clinical Explanation &amp; Rationale:
                        </label>
                        <textarea
                          className="qa-expl-box"
                          value={q.explanation}
                          rows={4}
                          placeholder="Enter detailed clinical rationale, explanation of why this answer is correct, and exam pearls..."
                          onChange={(e) => updateQuestionExplanation(qIndex, e.target.value)}
                        />
                      </div>
                    </div>
                  ))}

                  <div style={{ textAlign: 'center', padding: '10px 0 16px' }}>
                    <button
                      type="button"
                      className="admin-button admin-button-primary"
                      onClick={addNewQuestion}
                      style={{ padding: '8px 20px', fontSize: '0.84rem' }}
                    >
                      <Plus size={16} /> + Add Another Question
                    </button>
                  </div>
                </div>
              )}
            </div>
          )}

          {/* ─── TAB 2: LIVE STUDENT PREVIEW ─── */}
          {lessonTab === 'preview' && (
            <div className="editor-dialog-scrollable">
              {questionsList.length === 0 ? (
                <div style={{ padding: '30px 20px', textAlign: 'center', background: '#f8fafc', borderRadius: 8 }}>
                  <AlertCircle size={32} style={{ color: '#d97706', margin: '0 auto 10px' }} />
                  <h4 style={{ margin: '0 0 6px', color: '#1e293b' }}>No questions to display in preview</h4>
                  <p style={{ margin: '0 0 16px', color: '#64748b', fontSize: '0.84rem' }}>
                    Add questions in the Q&A Editor tab to see the live preview immediately.
                  </p>
                </div>
              ) : (
                <div className="quiz-preview-list">
                  <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '6px 4px', borderBottom: '1px solid #e2e8f0', marginBottom: 8 }}>
                    <span style={{ fontWeight: 700, fontSize: '0.86rem', color: '#0f172a' }}>
                      Live preview of {questionsList.length} questions as seen by students:
                    </span>
                    <span style={{ fontSize: '0.78rem', color: '#059669', background: '#ecfdf5', padding: '3px 10px', borderRadius: 12, fontWeight: 700 }}>
                      Verified by Medical Quiz Parser ✓
                    </span>
                  </div>
                  {questionsList.map((q, idx) => (
                    <div key={q.id || idx} className="quiz-preview-card">
                      <div className="quiz-preview-head">
                        <span className="quiz-preview-qnum">Question {q.questionNumber || idx + 1}</span>
                        <span style={{ fontSize: '0.76rem', background: '#ecfdf5', color: '#065f46', padding: '3px 10px', borderRadius: 4, fontWeight: 700, border: '1px solid #a7f3d0' }}>
                          Correct Answer: <strong>{q.correctKey || 'Not specified'}</strong>
                        </span>
                      </div>
                      <p style={{ fontWeight: 600, fontSize: '0.88rem', color: '#1e293b', margin: '6px 0 10px', lineHeight: 1.5 }}>
                        {q.stem}
                      </p>
                      <ul className="quiz-preview-opt-list">
                        {(q.options || []).map((opt) => {
                          const isCorrect = opt.key.toUpperCase() === q.correctKey?.toUpperCase();
                          return (
                            <li key={opt.key} className={`quiz-preview-opt ${isCorrect ? 'is-correct' : ''}`}>
                              <strong style={{ minWidth: 22 }}>{opt.key}.</strong>
                              <span style={{ flex: 1 }}>{opt.text}</span>
                              {isCorrect && (
                                <span style={{ marginLeft: 'auto', display: 'flex', alignItems: 'center', gap: 4, fontSize: '0.75rem', fontWeight: 700, color: '#059669' }}>
                                  <Check size={14} /> Correct Answer
                                </span>
                              )}
                            </li>
                          );
                        })}
                      </ul>
                      {q.explanation && (
                        <div className="quiz-preview-expl">
                          <strong style={{ display: 'block', color: '#0d9488', marginBottom: 4 }}>Clinical Explanation &amp; Rationale:</strong>
                          <div style={{ whiteSpace: 'pre-line' }}>{q.explanation}</div>
                        </div>
                      )}
                    </div>
                  ))}
                </div>
              )}
            </div>
          )}

          {/* ─── TAB 3: LESSON SETTINGS & RAW MARKDOWN ─── */}
          {lessonTab === 'settings' && (
            <div className="editor-dialog-scrollable">
              <label className="admin-field">
                Lesson title
                <input required autoFocus {...lessonForm.register('title', { required: true })} data-testid="input-lesson-title" />
              </label>
              <div className="field-pair">
                <label className="admin-field">
                  Lesson slug
                  <input required pattern="[a-z0-9-]+" {...lessonForm.register('slug', { required: true, pattern: /^[a-z0-9-]+$/ })} data-testid="input-lesson-slug" />
                </label>
                <label className="admin-field">
                  Content type
                  <select {...lessonForm.register('type')} data-testid="select-lesson-type">
                    {lessonTypes.map((type) => (
                      <option value={type} key={type}>
                        {type[0].toUpperCase() + type.slice(1)}
                      </option>
                    ))}
                  </select>
                </label>
              </div>

              <label className="admin-field">
                Raw Markdown Body:
                <textarea
                  rows={12}
                  {...lessonForm.register('body')}
                  style={{
                    fontFamily: 'ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace',
                    fontSize: '0.84rem',
                    lineHeight: 1.6,
                    minHeight: '220px',
                    padding: '10px 12px',
                  }}
                  placeholder="Raw markdown text..."
                  data-testid="input-lesson-body"
                />
              </label>

              <div className="field-pair">
                <label className="admin-field">
                  Duration in seconds
                  <input type="number" min="0" {...lessonForm.register('durationSeconds')} placeholder="Optional" data-testid="input-lesson-duration" />
                </label>
                <label className="admin-field">
                  Publication status
                  <select {...lessonForm.register('status')} data-testid="select-lesson-status">
                    {statuses.map((status) => (
                      <option value={status} key={status}>
                        {status[0].toUpperCase() + status.slice(1)}
                      </option>
                    ))}
                  </select>
                </label>
              </div>

              <label className="check-field preview-checkbox">
                <input type="checkbox" {...lessonForm.register('isFreePreview')} data-testid="checkbox-lesson-preview" />
                <span><strong>Free preview</strong><small>Allow learners to preview this lesson</small></span>
              </label>

              {editor.lesson && (
                <div className="asset-uploader">
                  <div className="asset-upload-top">
                    <span className="asset-upload-icon"><UploadCloud size={18} /></span>
                    <div><strong>Lesson media</strong><small>PDF, video, audio or common image formats</small></div>
                  </div>
                  <label className={`upload-drop ${upload.busy ? 'uploading' : ''}`}>
                    <input
                      type="file"
                      {...mediaFileField}
                      accept=".pdf,video/*,audio/*,image/png,image/jpeg,image/webp,image/gif,image/avif"
                      disabled={upload.busy}
                      onChange={(event) => {
                        const file = event.target.files?.[0];
                        void mediaFileField.onChange(event);
                        void uploadFile(file);
                        event.currentTarget.value = '';
                      }}
                      data-testid="input-lesson-media"
                    />
                    <span>
                      {upload.busy ? <LoaderCircle size={18} className="upload-spin" /> : <UploadCloud size={18} />}
                      {upload.busy ? `Uploading ${upload.filename}` : 'Choose a file to attach'}
                    </span>
                    <small>File bytes are uploaded directly to secure storage.</small>
                  </label>
                  {upload.busy && (
                    <div className="upload-progress" aria-label={`Upload ${upload.progress}%`}>
                      <span style={{ transform: `scaleX(${upload.progress / 100})` }} />
                    </div>
                  )}
                  {(upload.filename || editor.lesson.assetFilename) && !upload.busy && (
                    <div className="attached-asset">
                      <Check size={15} />
                      <span>{upload.filename || editor.lesson.assetFilename}</span>
                      <small>Attached</small>
                    </div>
                  )}
                  {upload.error && <p className="admin-form-error" role="alert">{upload.error}</p>}
                </div>
              )}
            </div>
          )}

          {modalError && <p className="admin-form-error" role="alert">{modalError}</p>}
          <div className="dialog-actions" style={{ marginTop: 16 }}>
            <button type="button" className="admin-button admin-button-quiet" onClick={() => setEditor(null)} disabled={upload.busy}>
              Cancel
            </button>
            <button type="submit" className="admin-button admin-button-primary" disabled={isModalSaving || upload.busy}>
              {isModalSaving ? 'Saving…' : editor.lesson ? 'Save Lesson' : 'Create Lesson'}
            </button>
          </div>
        </form></Form>}
      </section>
    </div>}
  </AdminLayout>;
}
