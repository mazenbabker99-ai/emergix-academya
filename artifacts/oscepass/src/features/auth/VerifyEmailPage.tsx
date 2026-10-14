import { useState } from 'react';
import { ArrowRight, BookOpen, MessageCircle } from 'lucide-react';
import { useForm } from 'react-hook-form';
import { Link } from 'wouter';
import { appUrl, authClient } from '@/lib/auth-client';
import { usePageMeta } from '@/lib/usePageMeta';
import { zodResolver } from '@/lib/zodResolver';
import { AuthShell } from './AuthShell';
import { useAuth } from './AuthProvider';
import { Field } from './components/Field';
import { forgotPasswordSchema, type ForgotPasswordValues } from './schemas';

/** Landing page after the confirmation link (Better Auth redirects here, adding ?error=… on failure). */
export function VerifyEmailPage() {
  usePageMeta('Confirm your e-mail', 'Confirm your e-mail address.');
  const { user, isPending } = useAuth();
  const failed = !!new URLSearchParams(window.location.search).get('error');
  const [resent, setResent] = useState(false);
  const form = useForm<ForgotPasswordValues>({ resolver: zodResolver(forgotPasswordSchema), defaultValues: { email: '' } });

  async function resend(values: ForgotPasswordValues) {
    await authClient.sendVerificationEmail({ email: values.email, callbackURL: appUrl('/verify-email') });
    setResent(true);
  }

  if (failed) {
    return (
      <AuthShell eyebrow="E-mail confirmation" title="That link did not work." intro="It may have expired or already been used. Enter your e-mail address and we will send a new one." onSubmit={resent ? undefined : form.handleSubmit(resend)}>
        {resent ? (
          <div className="notice" role="status">If an account exists for that address, a new confirmation e-mail is on its way.</div>
        ) : (
          <>
            <Field id="auth-email" type="email" label="Email address" autoComplete="email" registration={form.register('email')} error={form.formState.errors.email?.message} />
            <button className="btn btn-primary" type="submit">Send a new link</button>
          </>
        )}
      </AuthShell>
    );
  }

  return (
    <AuthShell eyebrow="E-mail confirmation" title={isPending ? 'Checking…' : 'Your e-mail address is confirmed.'}>
      {!isPending && (
        <div className="verified-onboarding">
          <div className="notice" role="status">Thank you — your account is verified and ready! Choose how you would like to begin:</div>
          <div style={{ display: 'grid', gap: '10px', marginTop: '16px' }}>
            <Link href={user ? '/app/membership' : '/login?next=/app/membership'} className="btn btn-primary" style={{ justifyContent: 'center' }}>
              <MessageCircle size={16} /> Choose course offer & Subscribe <ArrowRight size={15} />
            </Link>
            <Link href={user ? '/courses' : '/login?next=/courses'} className="btn btn-outline" style={{ justifyContent: 'center' }}>
              <BookOpen size={16} /> Continue with free courses
            </Link>
            {user && (
              <p className="auth-bottom" style={{ margin: '8px 0 0', textAlign: 'center' }}>
                <Link href="/app">Go directly to dashboard</Link>
              </p>
            )}
          </div>
        </div>
      )}
    </AuthShell>
  );
}
