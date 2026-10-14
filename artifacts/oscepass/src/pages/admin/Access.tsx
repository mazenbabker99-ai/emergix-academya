import { useState, type FormEvent } from 'react';
import { useQueryClient } from '@tanstack/react-query';
import { Archive, Check, ChevronDown, CircleAlert, Edit3, LoaderCircle, Plus, Search, ShieldCheck, UserRound, X } from 'lucide-react';
import {
  getAdminGetMembershipSettingsQueryKey,
  getAdminListMembershipPlansQueryKey,
  getAdminListUserCourseAccessQueryKey,
  getAdminSearchAccessUsersQueryKey,
  getListMembershipOffersQueryKey,
  useAdminArchiveMembershipPlan,
  useAdminCreateMembershipPlan,
  useAdminGetMembershipSettings,
  useAdminGrantUserCourseAccess,
  useAdminListCourses,
  useAdminListMembershipPlans,
  useAdminListUserCourseAccess,
  useAdminRevokeCourseAccess,
  useAdminSearchAccessUsers,
  useAdminUpdateMembershipPlan,
  useAdminUpdateMembershipSettings,
  type AdminMembershipPlan,
  type MembershipPlanInput,
} from '@workspace/api-client-react';
import { AdminLayout } from '@/components/layouts/AdminLayout';
import { ErrorState, PageSkeleton } from '@/components/shared/DataState';
import { usePageMeta } from '@/lib/usePageMeta';

type PlanDraft = { name: string; description: string; accessMonths: string; amount: string; currency: string; courseIds: string[]; status: 'draft' | 'published' };
const blankDraft: PlanDraft = { name: '', description: '', accessMonths: '1', amount: '', currency: 'SAR', courseIds: [], status: 'draft' };

function planDraft(plan?: AdminMembershipPlan): PlanDraft {
  return plan ? { name: plan.name, description: plan.description, accessMonths: String(plan.accessMonths), amount: (plan.amountMinor / 100).toFixed(2), currency: plan.currency, courseIds: plan.courses.map((course) => course.id), status: plan.status === 'published' ? 'published' : 'draft' } : blankDraft;
}
function displayMoney(amount: number, currency: string) {
  try { return new Intl.NumberFormat(undefined, { style: 'currency', currency }).format(amount / 100); } catch { return `${(amount / 100).toFixed(2)} ${currency}`; }
}
function dateLabel(value: string | null) {
  if (!value) return 'No expiry';
  return new Intl.DateTimeFormat(undefined, { dateStyle: 'medium' }).format(new Date(value));
}

export default function AdminAccess() {
  usePageMeta('Course access administration', 'Manage course offers and learner access.');
  const client = useQueryClient();
  const plansQuery = useAdminListMembershipPlans();
  const settingsQuery = useAdminGetMembershipSettings();
  const coursesQuery = useAdminListCourses({ limit: 100 });
  const [query, setQuery] = useState('');
  const [selectedUserId, setSelectedUserId] = useState('');
  const [draft, setDraft] = useState<PlanDraft>(blankDraft);
  const [editingId, setEditingId] = useState<string | null>(null);
  const [showEditor, setShowEditor] = useState(false);
  const [whatsapp, setWhatsapp] = useState('');
  const [feedback, setFeedback] = useState('');
  const usersQuery = useAdminSearchAccessUsers({ q: query.trim() }, { query: { enabled: query.trim().length >= 2, queryKey: getAdminSearchAccessUsersQueryKey({ q: query.trim() }) } });
  const accessQuery = useAdminListUserCourseAccess(selectedUserId, { query: { enabled: !!selectedUserId, queryKey: getAdminListUserCourseAccessQueryKey(selectedUserId) } });
  const saveSettings = useAdminUpdateMembershipSettings();
  const createPlan = useAdminCreateMembershipPlan();
  const updatePlan = useAdminUpdateMembershipPlan();
  const archivePlan = useAdminArchiveMembershipPlan();
  const grantAccess = useAdminGrantUserCourseAccess();
  const revokeAccess = useAdminRevokeCourseAccess();

  const settingsNumber = settingsQuery.data?.settings.whatsappNumber ?? '';
  const availablePlans = (plansQuery.data ?? []).filter((plan) => plan.status === 'published');

  async function saveWhatsapp(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setFeedback('');
    try {
      await saveSettings.mutateAsync({ data: { whatsappNumber: whatsapp.trim() || settingsNumber } });
      await Promise.all([client.invalidateQueries({ queryKey: getAdminGetMembershipSettingsQueryKey() }), client.invalidateQueries({ queryKey: getListMembershipOffersQueryKey() })]);
      setFeedback('WhatsApp number saved.');
    } catch { setFeedback('Could not save the WhatsApp number. Check the number and try again.'); }
  }
  function startCreate() { setEditingId(null); setDraft({ ...blankDraft }); setShowEditor(true); setFeedback(''); }
  function startEdit(plan: AdminMembershipPlan) { setEditingId(plan.id); setDraft(planDraft(plan)); setShowEditor(true); setFeedback(''); }
  async function savePlan(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    const input: MembershipPlanInput = { name: draft.name.trim(), description: draft.description.trim(), accessMonths: Number(draft.accessMonths), amountMinor: Math.round(Number(draft.amount) * 100), currency: draft.currency.trim().toUpperCase(), courseIds: draft.courseIds, status: draft.status };
    setFeedback('');
    try {
      if (editingId) await updatePlan.mutateAsync({ id: editingId, data: input });
      else await createPlan.mutateAsync({ data: input });
      await Promise.all([client.invalidateQueries({ queryKey: getAdminListMembershipPlansQueryKey() }), client.invalidateQueries({ queryKey: getAdminGetMembershipSettingsQueryKey() }), client.invalidateQueries({ queryKey: getListMembershipOffersQueryKey() })]);
      setShowEditor(false);
      setFeedback(editingId ? 'Offer updated.' : 'Offer created.');
    } catch { setFeedback('The offer could not be saved. Check required fields and try again.'); }
  }
  async function doArchive(plan: AdminMembershipPlan) {
    if (!window.confirm(`Archive “${plan.name}”? Learners will no longer see it as a published offer.`)) return;
    try {
      await archivePlan.mutateAsync({ id: plan.id });
      await Promise.all([client.invalidateQueries({ queryKey: getAdminListMembershipPlansQueryKey() }), client.invalidateQueries({ queryKey: getAdminGetMembershipSettingsQueryKey() }), client.invalidateQueries({ queryKey: getListMembershipOffersQueryKey() })]);
      setFeedback('Offer archived.');
    } catch { setFeedback('Could not archive this offer. Please try again.'); }
  }
  async function grant(planId: string) {
    if (!selectedUserId || !planId) return;
    try {
      await grantAccess.mutateAsync({ id: selectedUserId, data: { planId } });
      await client.invalidateQueries({ queryKey: getAdminListUserCourseAccessQueryKey(selectedUserId) });
      setFeedback('Course access granted.');
    } catch { setFeedback('Could not grant access. Check that the offer is published and try again.'); }
  }
  async function revoke(grantId: string, courseTitle: string) {
    if (!window.confirm(`Revoke access to “${courseTitle}”?`)) return;
    try {
      await revokeAccess.mutateAsync({ grantId });
      await client.invalidateQueries({ queryKey: getAdminListUserCourseAccessQueryKey(selectedUserId) });
      setFeedback('Course access revoked.');
    } catch { setFeedback('Could not revoke access. Please try again.'); }
  }
  const saving = createPlan.isPending || updatePlan.isPending;

  return <AdminLayout>
    <main className="access-admin">
      <header className="admin-access-heading"><div><span className="eyebrow">Academy operations</span><h1>Course access</h1><p>Review WhatsApp payments, publish offers and manage learner entitlements.</p></div><div className="admin-status-mark"><ShieldCheck size={20} /><span>Manual review<br />workflow</span></div></header>
      {feedback && <div className="access-feedback" role="status"><Check size={16} />{feedback}<button type="button" aria-label="Dismiss message" onClick={() => setFeedback('')}><X size={15} /></button></div>}

      <section className="admin-access-section settings-strip">
        <div className="section-label"><span className="section-count">01</span><div><h2>WhatsApp contact</h2><p>Payment conversations and receipts go to this number.</p></div></div>
        {settingsQuery.isLoading ? <div className="skeleton-line" /> : settingsQuery.isError ? <ErrorState onRetry={() => void settingsQuery.refetch()} /> :
          <form className="whatsapp-settings-form" onSubmit={saveWhatsapp}>
            <label htmlFor="whatsapp-number">WhatsApp number</label>
            <div><input id="whatsapp-number" value={whatsapp || settingsNumber} onChange={(event) => setWhatsapp(event.target.value)} minLength={8} maxLength={20} required data-testid="input-whatsapp-number" /><button className="btn btn-primary" type="submit" disabled={saveSettings.isPending} data-testid="button-save-whatsapp">{saveSettings.isPending ? 'Saving…' : 'Save number'}</button></div>
            <small>Include country code, for example +966563169123.</small>
          </form>}
      </section>

      <section className="admin-access-section offers-admin-section">
        <div className="section-heading-row"><div className="section-label"><span className="section-count">02</span><div><h2>Subscription offers</h2><p>Set the term, price and included courses. Only published offers appear to learners.</p></div></div><button className="btn btn-primary" type="button" onClick={startCreate} data-testid="button-new-offer"><Plus size={16} /> New offer</button></div>
        {plansQuery.isLoading && <PageSkeleton rows={3} label="Loading offers" />}
        {plansQuery.isError && <ErrorState onRetry={() => void plansQuery.refetch()} />}
        {!plansQuery.isLoading && !plansQuery.isError && (plansQuery.data ?? []).length === 0 && <div className="admin-empty"><BookOpenIcon /><h3>No offers created</h3><p>Create your first offer to define the course access learners can request.</p><button className="btn btn-outline" type="button" onClick={startCreate}>Create an offer</button></div>}
        <div className="admin-plan-list">{(plansQuery.data ?? []).map((plan) => <article className="admin-plan-row" key={plan.id} data-testid={`row-plan-${plan.id}`}>
          <div className="plan-row-main"><span className={`plan-status status-${plan.status}`}>{plan.status}</span><h3>{plan.name}</h3><p>{plan.description || 'No description provided.'}</p></div>
          <div className="plan-row-metric"><strong>{displayMoney(plan.amountMinor, plan.currency)}</strong><span>{plan.accessMonths} {plan.accessMonths === 1 ? 'month' : 'months'}</span></div>
          <div className="plan-row-courses"><strong>{plan.courses.length} courses</strong><span>{plan.courses.map((course) => course.title).join(', ') || 'No courses selected'}</span></div>
          <div className="plan-row-actions"><button type="button" className="icon-action" onClick={() => startEdit(plan)} disabled={plan.status === 'archived'} aria-label={`Edit ${plan.name}`} data-testid={`button-edit-plan-${plan.id}`}><Edit3 size={16} /></button>{plan.status !== 'archived' && <button type="button" className="icon-action icon-action-danger" onClick={() => void doArchive(plan)} aria-label={`Archive ${plan.name}`} data-testid={`button-archive-plan-${plan.id}`}><Archive size={16} /></button>}</div>
        </article>)}</div>
      </section>

      <section className="admin-access-section learner-access-section">
        <div className="section-label"><span className="section-count">03</span><div><h2>Learner access</h2><p>Find a learner after checking their payment confirmation, then grant the matching offer.</p></div></div>
        <div className="learner-search-wrap"><div className="access-search"><Search size={17} /><input value={query} onChange={(event) => setQuery(event.target.value)} placeholder="Search by name or email" aria-label="Search learners" data-testid="input-search-learners" /></div>
          {!selectedUserId && query.trim().length < 2 && <p className="search-hint">Enter at least two characters to search.</p>}
          {usersQuery.isLoading && query.trim().length >= 2 && <div className="access-search-state"><LoaderCircle size={16} /> Searching learners…</div>}
          {usersQuery.isError && <div className="access-error"><CircleAlert size={16} />We couldn’t search learners. Check your connection and try again.</div>}
          {query.trim().length >= 2 && !usersQuery.isLoading && !usersQuery.isError && <div className="learner-results" role="listbox" aria-label="Matching learners">
            {(usersQuery.data ?? []).length === 0 ? <p className="search-hint">No learners found for “{query}”. Try another name or email.</p> : (usersQuery.data ?? []).map((person) => <button type="button" key={person.id} className={`learner-result${person.id === selectedUserId ? ' learner-result-selected' : ''}`} onClick={() => { setSelectedUserId(person.id); setFeedback(''); }} data-testid={`button-select-learner-${person.id}`}><span className="learner-avatar"><UserRound size={17} /></span><span><strong>{person.name}</strong><small>{person.email}</small></span><ChevronDown size={15} /></button>)}
          </div>}
        </div>
        {selectedUserId && <div className="selected-access-panel">
          <div className="selected-panel-head"><div><span className="eyebrow">Selected learner</span><h3>{usersQuery.data?.find((user) => user.id === selectedUserId)?.name ?? 'Learner record'}</h3><p>{usersQuery.data?.find((user) => user.id === selectedUserId)?.email}</p></div><button className="btn btn-outline btn-compact" type="button" onClick={() => setSelectedUserId('')}>Clear selection</button></div>
          <div className="grant-control"><label htmlFor="grant-offer">Grant access from offer</label><select id="grant-offer" defaultValue="" onChange={(event) => { if (event.target.value) void grant(event.target.value); event.target.value = ''; }} disabled={grantAccess.isPending || availablePlans.length === 0} data-testid="select-grant-offer"><option value="" disabled>{availablePlans.length ? 'Select a published offer…' : 'No published offers available'}</option>{availablePlans.map((plan) => <option value={plan.id} key={plan.id}>{plan.name} · {plan.courses.length} courses</option>)}</select>{grantAccess.isPending && <span className="inline-pending">Granting…</span>}</div>
          <div className="grant-list-title"><h4>Course grants</h4><span>Active and revoked access</span></div>
          {accessQuery.isLoading && <PageSkeleton rows={2} label="Loading learner access" />}
          {accessQuery.isError && <ErrorState onRetry={() => void accessQuery.refetch()} />}
          {!accessQuery.isLoading && !accessQuery.isError && (accessQuery.data ?? []).length === 0 && <div className="grant-empty"><p>This learner has no course access grants yet.</p></div>}
          <div className="grant-list">{(accessQuery.data ?? []).map((grantItem) => <div className={`grant-row${grantItem.revokedAt ? ' grant-revoked' : ''}`} key={grantItem.id} data-testid={`row-grant-${grantItem.id}`}>
            <div><strong>{grantItem.courseTitle}</strong><span>{grantItem.planName ?? 'Manual access'} · Starts {dateLabel(grantItem.startsAt)} · Ends {dateLabel(grantItem.endsAt)}</span></div>
            {grantItem.revokedAt ? <span className="grant-state">Revoked {dateLabel(grantItem.revokedAt)}</span> : <button type="button" className="revoke-button" onClick={() => void revoke(grantItem.id, grantItem.courseTitle)} disabled={revokeAccess.isPending} data-testid={`button-revoke-grant-${grantItem.id}`}>Revoke</button>}
          </div>)}</div>
        </div>}
      </section>
    </main>

    {showEditor && <div className="access-modal-backdrop" role="presentation" onMouseDown={(event) => { if (event.target === event.currentTarget && !saving) setShowEditor(false); }}>
      <section className="offer-editor" role="dialog" aria-modal="true" aria-labelledby="offer-editor-title">
        <div className="offer-editor-head"><div><span className="eyebrow">Offer details</span><h2 id="offer-editor-title">{editingId ? 'Edit subscription offer' : 'Create subscription offer'}</h2><p>Amounts are entered in major currency units and saved in minor units.</p></div><button className="icon-action" type="button" onClick={() => setShowEditor(false)} aria-label="Close editor"><X size={18} /></button></div>
        <form onSubmit={(event) => void savePlan(event)} className="offer-editor-form">
          <label>Offer name<input value={draft.name} onChange={(event) => setDraft({ ...draft, name: event.target.value })} required minLength={2} maxLength={120} data-testid="input-offer-name" /></label>
          <label>Description<textarea value={draft.description} onChange={(event) => setDraft({ ...draft, description: event.target.value })} maxLength={1000} rows={3} data-testid="input-offer-description" /></label>
          <div className="editor-two-col"><label>Access duration (months)<input type="number" value={draft.accessMonths} min="1" max="120" onChange={(event) => setDraft({ ...draft, accessMonths: event.target.value })} required data-testid="input-offer-months" /></label><label>Price<input type="number" value={draft.amount} min="0.01" step="0.01" onChange={(event) => setDraft({ ...draft, amount: event.target.value })} required placeholder="Enter price" data-testid="input-offer-amount" /></label></div>
          <div className="editor-two-col"><label>Currency<input value={draft.currency} maxLength={3} minLength={3} onChange={(event) => setDraft({ ...draft, currency: event.target.value.toUpperCase() })} required placeholder="SAR" data-testid="input-offer-currency" /></label><label>Visibility<select value={draft.status} onChange={(event) => setDraft({ ...draft, status: event.target.value as PlanDraft['status'] })} data-testid="select-offer-status"><option value="draft">Draft</option><option value="published">Published</option></select></label></div>
          <fieldset className="course-picker"><legend>Courses included</legend>{coursesQuery.isLoading ? <span>Loading courses…</span> : coursesQuery.isError ? <div className="access-error">Could not load courses. Close this form and retry.</div> : (coursesQuery.data?.data ?? []).filter((course) => course.status === 'published').length === 0 ? <span>No published courses available.</span> : (coursesQuery.data?.data ?? []).filter((course) => course.status === 'published').map((course) => <label key={course.id} className="course-option"><input type="checkbox" checked={draft.courseIds.includes(course.id)} onChange={(event) => setDraft({ ...draft, courseIds: event.target.checked ? [...draft.courseIds, course.id] : draft.courseIds.filter((id) => id !== course.id) })} /><span><strong>{course.title}</strong><small>{course.lessonCount} lessons</small></span></label>)}</fieldset>
          {draft.courseIds.length === 0 && <p className="field-note">Select at least one published course.</p>}
          <div className="offer-editor-actions"><button type="button" className="btn btn-outline" onClick={() => setShowEditor(false)} disabled={saving}>Cancel</button><button type="submit" className="btn btn-primary" disabled={saving || draft.courseIds.length === 0 || coursesQuery.isLoading || coursesQuery.isError}>{saving ? 'Saving offer…' : editingId ? 'Save changes' : 'Create offer'}</button></div>
        </form>
      </section>
    </div>}
  </AdminLayout>;
}

function BookOpenIcon() {
  return <span className="empty-mark" aria-hidden="true">EA</span>;
}
