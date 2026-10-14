import type { ReactNode } from 'react';
import { ShellLayout } from './ShellLayout';

export function AdminLayout({ children }: { children: ReactNode }) {
  return (
    <ShellLayout
      area="Admin"
      nav={[
        { href: '/admin', label: 'Courses (الكورسات)' },
        { href: '/admin/access', label: 'Subscriptions & Access (تأكيد الاشتراكات)' },
        { href: '/admin/questions', label: 'Question Bank (بنك الأسئلة)' },
        { href: '/app', label: 'Learner View (عرض الطالب)' },
      ]}
    >
      {children}
    </ShellLayout>
  );
}
