import { Award, BookOpen, CheckCircle2, ClipboardCheck, Clock3, FileText, Headphones, HeartPulse, MessageCircle, Play, ShieldCheck, Stethoscope, Video } from 'lucide-react';

export const modules = [
  { icon: BookOpen, title: 'MRCEM Primary Notes', description: '221 high-yield topics covering Anatomy, Physiology, Pathology, and Pharmacology.', color: '#0A84FF', image: '/brand/t1.jpg', href: '/courses/mrcem-primary' },
  { icon: ClipboardCheck, title: 'Topical SBA Bank', description: '41 system-specific single-best-answer question sets with step-by-step rationales.', color: '#7C3AED', image: '/brand/t2.jpg', href: '/courses/mrcem-sba' },
  { icon: Clock3, title: 'Mock Exam Simulations', description: '3 full mock exams (6 papers) simulating authentic RCEM exam timing.', color: '#16A34A', image: '/brand/t3.jpg', href: '/courses/mrcem-sba' },
  { icon: Award, title: 'Previous Exam Recalls', description: 'Solved past RCEM Primary and SBA questions with conceptual explanations.', color: '#0D9488', image: '/brand/t4.jpg', href: '/courses' },
  { icon: MessageCircle, title: 'WhatsApp Mentorship', description: 'Direct 1-to-1 tutor support and prompt answers to tricky clinical queries.', color: '#DB2777', image: '/brand/t5.jpg', href: '/app/membership' },
  { icon: ShieldCheck, title: 'Comprehensive Bundle', description: 'Full access to all 268 lessons, question banks, and mock simulations.', color: '#4F46E5', image: '/brand/t6.jpg', href: '/app/membership' },
];

export const features = [
  { icon: BookOpen, title: 'High-Yield Notes', text: 'Concise clinical summaries across Anatomy, Physiology, Pathology, Pharmacology, and Microbiology.' },
  { icon: ClipboardCheck, title: 'Topical SBA Bank', text: '41 system-focused question sets with detailed conceptual rationales and explanations.' },
  { icon: FileText, title: 'Previous Recalls', text: 'Solved past RCEM examination recalls with examiner pearls and key insights.' },
  { icon: Clock3, title: 'Timed Mock Simulations', text: 'Authentic 3-hour computer-based exam papers mirroring Royal College test conditions.' },
  { icon: HeartPulse, title: 'Fast Curriculum Coverage', text: 'Designed to complete high-yield revision of the entire syllabus in 2 to 2.5 months.' },
  { icon: Headphones, title: 'WhatsApp Mentorship', text: 'Direct 1-on-1 tutor support and prompt discussion of tricky clinical questions.' },
  { icon: ShieldCheck, title: 'Verified Student Access', text: 'Instant activation, structured progress tracking, and continuous material updates.' },
];

export const testimonials = [
  {
    quote: 'Emergix Academy’s revision notes were an absolute game changer for my MRCEM Primary. The concise summaries and past recalls covered exactly what appeared on the exam. Passed on my 1st attempt!',
    author: 'Dr. Deepan Jayapala',
    role: 'Emergency Medicine Trainee',
    exam: 'Passed MRCEM Primary (1st Attempt)',
  },
  {
    quote: 'The SBA question bank and timed mock exams mirror the real RCEM computer-based test format perfectly. The detailed explanations helped me understand the clinical reasoning behind tricky questions.',
    author: 'Dr. Rao Erbaz Hassan',
    role: 'Emergency Physician',
    exam: 'Passed MRCEM Intermediate SBA',
  },
  {
    quote: 'Clear, structured, and strictly high-yield. Studying for the MRCEM while working full shifts in the Emergency Department is tough, but this platform made revision fast and effective.',
    author: 'Dr. Hamza Farooq',
    role: 'Emergency Department Registrar',
    exam: 'Passed MRCEM SBA (1st Attempt)',
  },
];

