import { useMemo, useState } from 'react';
import { ArrowRight, CheckCircle2, MessageCircle, XCircle } from 'lucide-react';
import { Link } from 'wouter';
import { useGetPage } from '@workspace/api-client-react';
import { PageSkeleton } from '@/components/shared/DataState';
import { PageHero } from '@/components/shared/PageHero';
import { Prose } from '@/components/shared/Prose';
import { SiteLayout } from '@/components/shared/SiteLayout';
import { usePageMeta } from '@/lib/usePageMeta';

interface DemoOption { key: string; text: string; rationale: string }
interface DemoQuestion { id: string; stem: string; options: DemoOption[]; correct: string; keyPoint: string }
interface DemoData { questions: DemoQuestion[]; lesson?: { title: string; body: string } }

const defaultDemoData: DemoData = {
  questions: [
    {
      id: 'demo-q1',
      stem: 'A 28-year-old male sustains a stab wound to the axilla. On examination, he has marked weakness of forearm flexion and loss of sensation over the lateral aspect of the forearm. Which nerve has most likely been injured?',
      options: [
        { key: 'A', text: 'Median nerve', rationale: 'Innervates most forearm flexors and thenar muscles, but forearm flexion is primarily biceps/brachialis.' },
        { key: 'B', text: 'Musculocutaneous nerve', rationale: 'Innervates biceps brachii and brachialis (primary forearm flexors) and terminates as the lateral cutaneous nerve of the forearm.' },
        { key: 'C', text: 'Radial nerve', rationale: 'Innervates triceps and forearm extensors; injury causes wrist drop.' },
        { key: 'D', text: 'Ulnar nerve', rationale: 'Innervates FCU, medial FDP, and intrinsic hand muscles; injury causes claw hand.' },
        { key: 'E', text: 'Axillary nerve', rationale: 'Innervates deltoid and teres minor; sensory loss over regimental badge.' },
      ],
      correct: 'B',
      keyPoint: 'Musculocutaneous nerve (C5-C7) supplies biceps brachii and brachialis, continuing as the lateral cutaneous nerve of the forearm.',
    },
    {
      id: 'demo-q2',
      stem: 'A 22-year-old female presents to the Emergency Department 6 hours after ingesting 20 grams of paracetamol. Her serum paracetamol concentration is well above the treatment line on the nomogram. Which agent is the specific antidote of choice?',
      options: [
        { key: 'A', text: 'Naloxone', rationale: 'Opioid receptor antagonist, not indicated for paracetamol hepatotoxicity.' },
        { key: 'B', text: 'N-acetylcysteine (NAC)', rationale: 'Replenishes hepatocellular glutathione stores to detoxify toxic NAPQI.' },
        { key: 'C', text: 'Atropine', rationale: 'Antimuscarinic used for organophosphate poisoning and symptomatic bradycardia.' },
        { key: 'D', text: 'Flumazenil', rationale: 'Benzodiazepine antagonist, carries risk of inducing refractory seizures.' },
        { key: 'E', text: 'Deferoxamine', rationale: 'Iron chelator, not indicated for paracetamol ingestion.' },
      ],
      correct: 'B',
      keyPoint: 'N-acetylcysteine (NAC) restores glutathione stores, preventing toxic NAPQI-induced centrilobular hepatic necrosis.',
    },
    {
      id: 'demo-q3',
      stem: 'In a healthy adult subject, increasing ventricular end-diastolic volume directly increases stroke volume during the subsequent contraction. What cellular mechanism accounts for this Frank-Starling response?',
      options: [
        { key: 'A', text: 'Increased resting membrane potential', rationale: 'Resting membrane potential changes do not mediate length-dependent inotropy.' },
        { key: 'B', text: 'Optimized actin-myosin overlap and increased troponin C calcium sensitivity', rationale: 'Myocardial stretch brings cross-bridges into optimal spacing and increases troponin C affinity for calcium.' },
        { key: 'C', text: 'Direct beta-1 adrenergic phosphorylation', rationale: 'Beta-1 stimulation increases contractility via cAMP, but Frank-Starling is an intrinsic myogenic property.' },
        { key: 'D', text: 'Decreased sarcoplasmic reticulum calcium release', rationale: 'Decreased calcium release would decrease rather than augment contractile force.' },
        { key: 'E', text: 'Inhibition of the Na+/K+ ATPase pump', rationale: 'This describes digitalis glycoside action, not Starling\'s law.' },
      ],
      correct: 'B',
      keyPoint: 'The Frank-Starling mechanism relies on length-dependent activation: myofilament stretch optimizes actin-myosin overlap and enhances troponin C affinity for calcium.',
    },
  ],
  lesson: {
    title: 'High-Yield Summary: Anatomy of the Cubital Fossa',
    body: `### Boundaries and Contents of the Cubital Fossa

The cubital fossa is a triangular depression on the anterior aspect of the elbow.

#### Boundaries
- **Superior:** Imaginary horizontal line connecting the medial and lateral epicondyles of the humerus.
- **Medial:** Lateral border of the pronator teres muscle.
- **Lateral:** Medial border of the brachioradialis muscle.
- **Floor:** Brachialis (proximally) and supinator (distally).
- **Roof:** Skin, superficial fascia containing the median cubital vein, bicipital aponeurosis, and deep fascia.

#### Contents (From Medial to Lateral: M-B-B-R)
1. **Median Nerve:** Leaves the fossa between the two heads of pronator teres.
2. **Brachial Artery:** Bifurcates into radial and ulnar arteries at the apex of the fossa.
3. **Biceps Brachii Tendon:** Inserts into the radial tuberosity; lateral to the brachial artery.
4. **Radial Nerve:** Lies deep in the groove between brachialis and brachioradialis.

> [!TIP]
> **Examiner Pearl:** The bicipital aponeurosis separates the superficial median cubital vein from the deep brachial artery, protecting the artery during venipuncture.`,
  },
};

/** Defensive read of the CMS JSON: the admin editor can store anything, so never trust its shape. */
export function parseDemo(data: unknown): DemoData {
  const d = (data ?? {}) as { questions?: unknown; lesson?: { title?: unknown; body?: unknown } };
  const questions = (Array.isArray(d.questions) ? d.questions : []).filter((q): q is DemoQuestion =>
    !!q && typeof q.id === 'string' && typeof q.stem === 'string' && Array.isArray(q.options) && typeof q.correct === 'string');
  const lesson = typeof d.lesson?.title === 'string' && typeof d.lesson?.body === 'string' ? { title: d.lesson.title, body: d.lesson.body } : undefined;
  return { questions, lesson };
}

function Question({ q, index, onAnswer }: { q: DemoQuestion; index: number; onAnswer: (correct: boolean) => void }) {
  const [picked, setPicked] = useState<string | null>(null);
  const answered = picked !== null;
  return <article className="qd-card" aria-labelledby={`${q.id}-stem`}>
    <p className="qd-meta">Question {index + 1} · SAMPLE</p>
    <h3 id={`${q.id}-stem`}>{q.stem}</h3>
    <fieldset disabled={answered} className="qd-options">
      <legend className="sr-only">Choose one answer</legend>
      {q.options.map((o) => {
        const state = !answered ? '' : o.key === q.correct ? 'is-correct' : o.key === picked ? 'is-wrong' : '';
        return <label key={o.key} className={`qd-option ${state}`}>
          <input type="radio" name={q.id} value={o.key} checked={picked === o.key} onChange={() => { setPicked(o.key); onAnswer(o.key === q.correct); }} />
          <span><strong>{o.key}.</strong> {o.text}</span>
        </label>;
      })}
    </fieldset>
    <div aria-live="polite">{answered && <div className="qd-feedback">
      <p className="qd-result">{picked === q.correct ? <><CheckCircle2 size={18} aria-hidden="true" /> Correct</> : <><XCircle size={18} aria-hidden="true" /> Not quite: the answer is {q.correct}</>}</p>
      <ul>{q.options.map((o) => <li key={o.key}><strong>{o.key}.</strong> {o.rationale}</li>)}</ul>
      <p><strong>Key point:</strong> {q.keyPoint}</p>
    </div>}</div>
  </article>;
}

export default function FreeDemo() {
  usePageMeta('Free Demo - Sample MRCEM Questions', 'Try sample MRCEM Primary exam-style questions and a high-yield lesson with no account needed.');
  const { data, isLoading } = useGetPage('free-demo');
  const demo = useMemo(() => {
    const parsed = parseDemo(data?.data);
    if (parsed.questions.length > 0) return parsed;
    return defaultDemoData;
  }, [data]);
  const [score, setScore] = useState({ answered: 0, correct: 0 });

  return <SiteLayout><main>
    <PageHero eyebrow="Free Demo" title="Try high-yield practice questions." intro="Sample MRCEM Primary SBA questions and a concise revision lesson. No account or payment required." />
    <section className="section"><div className="container qd-layout">
      <div className="notice" role="note">Sample content for practice and revision. Prepared according to the Royal College of Emergency Medicine syllabus.</div>
      {isLoading && !demo.questions.length && <PageSkeleton label="Loading demo" />}
      {demo.questions.map((q, i) => <Question key={q.id} q={q} index={i} onAnswer={(ok) => setScore((s) => ({ answered: s.answered + 1, correct: s.correct + (ok ? 1 : 0) }))} />)}
      {demo.questions.length > 0 && <p className="qd-score" role="status">Answered {score.answered} of {demo.questions.length} · {score.correct} correct</p>}
      {demo.lesson && <article className="qd-lesson"><h2>{demo.lesson.title}</h2><Prose text={demo.lesson.body} /></article>}
      <div className="cta-panel" style={{ marginTop: 36 }}>
        <div>
          <h2>Ready for the complete question bank?</h2>
          <p>Get full access to all 268 lessons, 41 topical SBA quizzes, and 6 full mock exam papers.</p>
        </div>
        <div style={{ display: 'flex', gap: 12, flexWrap: 'wrap' }}>
          <Link className="btn btn-primary" href="/courses/mrcem-primary">
            Explore MRCEM Primary <ArrowRight size={16} aria-hidden="true" />
          </Link>
          <Link className="btn btn-light" href="/app/membership">
            <MessageCircle size={15} /> Subscribe via WhatsApp
          </Link>
        </div>
      </div>
    </div></section>
  </main></SiteLayout>;
}

