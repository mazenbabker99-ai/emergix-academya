import { useState } from 'react';
import { ArrowUpRight, BookOpen, Check, Clock3, MessageCircle, ShieldCheck, Sparkles } from 'lucide-react';
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

  function whatsappUrl(offer?: (typeof offers)[number]) {
    const studentInfo = `${user?.name ?? 'Learner'}${user?.email ? ` (${user.email})` : ''}`;
    const offerDetails = offer
      ? `Plan: "${offer.name}" (${money(offer.amountMinor, offer.currency)} / ${offer.accessMonths} months)`
      : `Emergix Academy: MRCEM Primary Full Access`;

    const message = `Hello Emergix Academy Team,
Candidate: ${studentInfo}
Selected Plan: ${offerDetails}

I would like to subscribe to this plan. Please provide the transfer details so I can complete payment and activate full course access on the platform.`;

    return `https://wa.me/${number.replace(/\D/g, '')}?text=${encodeURIComponent(message)}`;
  }

  const directWhatsappLink = whatsappUrl();

  return (
    <AppLayout>
      <div className="membership-page">
        <header className="membership-intro">
          <div>
            <span className="eyebrow">Direct Verification & Instant Activation</span>
            <h1>Choose your course access.</h1>
            <p>Pick a course offer and message our team directly on WhatsApp. An administrator will verify your payment and activate your access immediately.</p>
          </div>
          <div className="access-seal">
            <ShieldCheck size={23} />
            <span>Manual payment<br />verification</span>
          </div>
        </header>

        <section className="membership-steps" aria-label="How course access works">
          <div><span className="step-index">01</span><span>Choose your course</span></div>
          <div><span className="step-index">02</span><span>Chat & Transfer on WhatsApp</span></div>
          <div><span className="step-index">03</span><span>Instant Activation</span></div>
        </section>

        <div className="membership-section-head">
          <div>
            <span className="eyebrow">Available Subscriptions</span>
            <h2>Built for MRCEM progress</h2>
          </div>
          <p>Payment is arranged directly with our administration team. No automated card charges.</p>
        </div>

        {offersQuery.isLoading && (
          <div className="membership-loading"><PageSkeleton rows={2} label="Loading course offers" /></div>
        )}

        {offersQuery.isError && (
          <ErrorState onRetry={() => void offersQuery.refetch()} />
        )}

        {/* Dynamic offers list if available */}
        {!offersQuery.isLoading && offers.length > 0 && (
          <div className="offer-grid">
            {offers.map((offer, index) => (
              <article
                className={`offer-card${selected === offer.id ? ' offer-card-selected' : ''}`}
                key={offer.id}
                data-testid={`card-offer-${offer.id}`}
              >
                <div className="offer-card-head">
                  <span className="offer-number">OFFER / {String(index + 1).padStart(2, '0')}</span>
                  <span className="offer-duration">
                    <Clock3 size={14} /> {offer.accessMonths} {offer.accessMonths === 1 ? 'month' : 'months'}
                  </span>
                </div>
                <h3>{offer.name}</h3>
                <p className="offer-description">{offer.description}</p>
                <div className="offer-price">
                  {money(offer.amountMinor, offer.currency)}
                  <span> / {offer.accessMonths} months</span>
                </div>
                <div className="offer-includes">
                  <strong>COURSES INCLUDED</strong>
                  <ul>
                    {offer.courses.map((course) => (
                      <li key={course.id}>
                        <Check size={15} />{course.title}
                      </li>
                    ))}
                  </ul>
                </div>
                <a
                  className="btn btn-primary offer-cta"
                  href={whatsappUrl(offer)}
                  target="_blank"
                  rel="noreferrer"
                  onClick={() => setSelected(offer.id)}
                  data-testid={`link-whatsapp-${offer.id}`}
                >
                  <MessageCircle size={17} /> Continue on WhatsApp <ArrowUpRight size={16} />
                </a>
                <p className="offer-footnote">Direct chat with administration to send payment receipt.</p>
              </article>
            ))}
          </div>
        )}

        {/* Fallback direct WhatsApp offer card if no dynamic offers configured yet */}
        {!offersQuery.isLoading && !offersQuery.isError && offers.length === 0 && (
          <div className="offer-grid" style={{ gridTemplateColumns: 'minmax(0, 560px)' }}>
            <article className="offer-card offer-card-selected" style={{ border: '2px solid #0066CC' }}>
              <div className="offer-card-head">
                <span className="offer-number" style={{ background: '#0066CC', color: '#fff' }}>FULL ACCESS</span>
                <span className="offer-duration"><Clock3 size={14} /> Comprehensive Access</span>
              </div>
              <h3>Emergix Academy: MRCEM Primary Full Access</h3>
              <p className="offer-description">
                Comprehensive access to all curriculum masterclasses, high-yield anatomy & physiology modules, complete SBA question bank, and continuous mentorship via WhatsApp.
              </p>
              <div className="offer-includes">
                <strong>INCLUDED IN THIS PLAN</strong>
                <ul>
                  <li><Check size={15} /> Full access to MRCEM Upper Limb Anatomy & all modules</li>
                  <li><Check size={15} /> Complete MRCEM SBA question bank</li>
                  <li><Check size={15} /> Instant manual verification & activation by our team</li>
                </ul>
              </div>
              <a
                className="btn btn-primary offer-cta"
                href={directWhatsappLink}
                target="_blank"
                rel="noreferrer"
                style={{ fontSize: '1rem', padding: '14px 20px' }}
              >
                <MessageCircle size={19} /> Subscribe & Activate via WhatsApp <ArrowUpRight size={16} />
              </a>
              <p className="offer-footnote">
                Chat directly with our team at {number} to arrange payment and activate your account.
              </p>
            </article>
          </div>
        )}

        <section className="free-course-panel" style={{ marginTop: 36 }}>
          <div className="free-mark"><BookOpen size={21} /></div>
          <div>
            <span className="eyebrow">Free options</span>
            <h2>Prefer to start with free courses?</h2>
            <p>Explore all preview lessons and free materials, and subscribe whenever you’re ready.</p>
          </div>
          <a className="btn btn-outline" href="/courses" data-testid="link-free-courses">
            Browse free courses <ArrowUpRight size={16} />
          </a>
        </section>

        <aside className="membership-assurance">
          <ShieldCheck size={18} />
          <span>Access is activated immediately after confirming transfer receipt. Need assistance? Message us on WhatsApp: <strong>{number}</strong></span>
        </aside>
      </div>
    </AppLayout>
  );
}
