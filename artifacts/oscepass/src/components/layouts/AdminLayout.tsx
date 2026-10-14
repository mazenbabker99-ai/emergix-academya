import type { ReactNode } from 'react';
import { ShellLayout } from './ShellLayout';

export function AdminLayout({ children }: { children: ReactNode }) {
  return <ShellLayout area="Admin" nav={[{ href: '/admin', label: 'Courses' }, { href: '/admin/questions', label: 'Question bank' }, { href: '/admin/access', label: 'Course access' }, { href: '/app', label: 'Learner view' }]}>{children}</ShellLayout>;
}
