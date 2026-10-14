import type { ReactNode } from 'react';
import { ShellLayout } from './ShellLayout';

export function AdminLayout({ children }: { children: ReactNode }) {
  return (
    <ShellLayout
      area="Admin"
      nav={[
        { href: '/admin', label: 'Courses' },
        { href: '/admin/access', label: 'Subscriptions & Access' },
        { href: '/admin/questions', label: 'Question Bank' },
        { href: '/app', label: 'Learner View' },
      ]}
    >
      {children}
    </ShellLayout>
  );
}
