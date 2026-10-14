import { useState } from 'react';
import { ArrowUpRight, BookOpen, Check, Clock3, MessageCircle, ShieldCheck } from 'lucide-react';
import { useListMembershipOffers } from '@workspace/api-client-react';
import { AppLayout } from '@/components/layouts/AppLayout';
import { ErrorState, PageSkeleton } from '@/components/shared/DataState';
import { useAuth } from '@/features/auth/AuthProvider';
import { usePageMeta } from '@/lib/usePageMeta';

function money(amountMinor: number, currency: string) {
  return new Intl.NumberFormat(undefined, { style: 'currency', currency }).format(amountMinor / 100);
}

export default function Membership() {
  usePageMeta('Course access', 'Choose a WhatsApp-verified course offer or continue with free courses.');
  const { user } = useAuth();
  const offersQuery = useListMembershipOffers();
  const [selected, setSelected] = useState<string | null>(null);
  const offers = offersQuery.data?.offers ?? [];
  const number = offersQuery.data?.settings.whatsappNumber ?? '+966563169123';

  function whatsappUrl(offer: (typeof offers)[number]) {
    const studentInfo = `${user?.name ?? 'Learner'}${user?.email ? ` (${user.email})` : ''}`;
    const priceFormatted = money(offer.amountMinor, offer.currency);
    const message = `مرحباً Emergix Academy،
أنا الطالب: ${studentInfo}.
أود الاشتراك في باقة: "${offer.name}" (${priceFormatted} / ${offer.accessMonths} أشهر).
أرجو تزويدي بتفاصيل الدفع لإرسال إشعار التحويل لتفعيل الاشتراك.

Hello Emergix Academy, I'm ${studentInfo}. I would like to subscribe to the "${offer.name}" offer (${priceFormatted} / ${offer.accessMonths} months). Please confirm payment details to send the transfer receipt for activation.`;
    return `https://wa.me/${number.replace(/\D/g, '')}?text=${encodeURIComponent(message)}`;
  }

  return <AppLayout>
    <div className="membership-page">
      <header className="membership-intro">
        <div>
          <span className="eyebrow">Your learning, your pace</span>
          <h1>Choose your course access.</h1>
          <p>Pick a course offer and message our team on WhatsApp. An administrator will verify your payment and activate access for you.</p>
        </div>
        <div className="access-seal"><ShieldCheck size={23} /><span>Manual payment<br />verification</span></div>
      </header>

      <section className="membership-steps" aria-label="How course access works">
        <div><span className="step-index">01</span><span>Choose an offer</span></div>
        <div><span className="step-index">02</span><span>Send payment receipt</span></div>
        <div><span className="step-index">03</span><span>Access is activated</span></div>
      </section>

      <div className="membership-section-head">
        <div><span className="eyebrow">Published offers</span><h2>Built for MRCEM progress</h2></div>
        <p>Payment is arranged directly with our team. No online checkout.</p>
      </div>

      {offersQuery.isLoading && <div className="membership-loading"><PageSkeleton rows={2} label="Loading course offers" /></div>}
      {offersQuery.isError && <ErrorState onRetry={() => void offersQuery.refetch()} />}
      {!offersQuery.isLoading && !offersQuery.isError && offers.length === 0 && <div className="membership-empty" data-testid="empty-membership-offers">
        <BookOpen size={27} /><h3>No offers are available just yet</h3><p>You can still make a start with the free courses in the academy.</p>
      </div>}

      {offers.length > 0 && <div className="offer-grid">
        {offers.map((offer, index) => <article className={`offer-card${selected === offer.id ? ' offer-card-selected' : ''}`} key={offer.id} data-testid={`card-offer-${offer.id}`}>
          <div className="offer-card-head"><span className="offer-number">OFFER / {String(index + 1).padStart(2, '0')}</span><span className="offer-duration"><Clock3 size={14} /> {offer.accessMonths} {offer.accessMonths === 1 ? 'month' : 'months'}</span></div>
          <h3>{offer.name}</h3>
          <p className="offer-description">{offer.description}</p>
          <div className="offer-price">{money(offer.amountMinor, offer.currency)}<span> / {offer.accessMonths} months</span></div>
          <div className="offer-includes"><strong>COURSES INCLUDED</strong>
            <ul>{offer.courses.map((course) => <li key={course.id}><Check size={15} />{course.title}</li>)}</ul>
          </div>
          <a className="btn btn-primary offer-cta" href={whatsappUrl(offer)} target="_blank" rel="noreferrer" onClick={() => setSelected(offer.id)} data-testid={`link-whatsapp-${offer.id}`}>
            <MessageCircle size={17} /> Continue on WhatsApp <ArrowUpRight size={16} />
          </a>
          <p className="offer-footnote">Send your payment confirmation or receipt to complete verification.</p>
        </article>)}
      </div>}

      <section className="free-course-panel">
        <div className="free-mark"><BookOpen size={21} /></div>
        <div><span className="eyebrow">A good place to begin</span><h2>Prefer to start with free courses?</h2><p>Explore the courses available at no cost, and choose paid access whenever you’re ready.</p></div>
        <a className="btn btn-outline" href="/courses" data-testid="link-free-courses">Browse free courses <ArrowUpRight size={16} /></a>
      </section>
      <aside className="membership-assurance"><ShieldCheck size={18} /><span>Your access is granted by our team only after payment is checked. Need help? WhatsApp us at <strong>{number}</strong>.</span></aside>
    </div>
  </AppLayout>;
}
