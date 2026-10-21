export interface NavLink {
  label: string;
  href: string;
  description?: string;
}

export interface NavItem extends NavLink {
  /** Which mega-menu panel opens from this item. */
  menu?: 'exams' | 'resources' | 'courses';
}

/**
 * Header navigation — MRCEM Primary & SBA focused platform.
 */
export const primaryNav: NavItem[] = [
  { label: 'Exams', href: '/exams', menu: 'exams' },
  { label: 'Courses', href: '/courses', menu: 'courses' },
  { label: 'Question Bank', href: '/question-bank' },
  { label: 'Pricing', href: '/pricing' },
  { label: 'Resources', href: '/resources', menu: 'resources' },
  { label: 'About', href: '/about' },
];

export const coursesMenu: NavLink[] = [
  {
    label: 'MRCEM PRIMARY',
    href: '/courses/mrcem-primary',
    description: 'Basic sciences masterclass (21 modules, 221 lessons, 269 figures)',
  },
  {
    label: 'MRCEM SBA',
    href: '/question-bank',
    description: 'Clinical SBA question bank (41 topic quizzes & 6 timed mock exams)',
  },
  {
    label: 'All Flagship Courses',
    href: '/courses',
    description: 'Explore both flagship tracks, syllabus and pricing packages',
  },
];

export const examsMenuExtras: NavLink[] = [
  { label: 'Compare all exams', href: '/exams', description: 'Format, length and structure side by side' },
  { label: 'MRCEM Primary', href: '/exams/mrcem-primary', description: 'Basic sciences: anatomy, physiology, pathology' },
  { label: 'MRCEM SBA', href: '/exams/mrcem-sba', description: 'Single best answer clinical reasoning exam' },
];

export const resourcesMenu: NavLink[] = [
  { label: 'Study resources', href: '/resources', description: 'High-yield guides and reference material' },
  { label: 'Blog and news', href: '/blog', description: 'Study tips and platform updates' },
  { label: 'Free demo', href: '/free-demo', description: 'Sample SBA questions — no account required' },
  { label: 'Contact us', href: '/contact', description: 'Get in touch with our support team' },
];

export const legalLinks: NavLink[] = [
  { label: 'Terms of use', href: '/legal/terms' },
  { label: 'Privacy policy', href: '/legal/privacy' },
  { label: 'Cookie policy', href: '/legal/cookies' },
  { label: 'Refund policy', href: '/legal/refunds' },
  { label: 'Medical disclaimer', href: '/legal/medical-disclaimer' },
];
