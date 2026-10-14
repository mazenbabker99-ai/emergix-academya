import { Brain, Mail, MapPin, Phone, Star, Target, UserRound } from 'lucide-react';
import { FaInstagram, FaLinkedinIn, FaXTwitter, FaYoutube } from 'react-icons/fa6';
import { Link } from 'wouter';
import { brand } from '@/config/brand';
import { legalLinks } from '@/config/navigation';
import { openCookieSettings } from '@/lib/consent';
import { Brand } from './Brand';

const socials = [
  { key: 'x', label: 'X (Twitter)', Icon: FaXTwitter },
  { key: 'linkedin', label: 'LinkedIn', Icon: FaLinkedinIn },
  { key: 'youtube', label: 'YouTube', Icon: FaYoutube },
  { key: 'instagram', label: 'Instagram', Icon: FaInstagram },
] as const;

export function Footer() {
  return <footer className="site-footer">
    <div className="container">
      <div className="trust-row" aria-label={`Why learners choose ${brand.name}`}>
        <div className="trust-items">
          <span><Target aria-hidden="true" />Designed for MRCEM Primary &amp; SBA success</span>
          <span><UserRound aria-hidden="true" />Flexible learning at your pace</span>
          <span><Star aria-hidden="true" />Expert-led and clinically relevant</span>
          <span><Brain aria-hidden="true" />High-yield notes &amp; authentic mock exams</span>
        </div>
        <p className="trust-slogan">Better preparation.<br />Greater confidence.<br /><strong>Pass your MRCEM.</strong></p>
      </div>
      <div className="footer-grid">
        <div className="footer-about">
          <Brand light />
          <p>Quick revision notes, high-yield SBA question banks and authentic mock simulations for emergency physicians.</p>
          <ul className="footer-social" aria-label="Social media">
            {socials.filter(({ key }) => brand.social[key]).map(({ key, label, Icon }) => <li key={key}><a href={brand.social[key]} target="_blank" rel="noopener noreferrer" aria-label={label}><Icon aria-hidden="true" /></a></li>)}
          </ul>
        </div>
        <nav className="footer-column" aria-label="Learn">
          <h3>Learn</h3>
          <Link href="/courses/mrcem-primary">MRCEM Primary</Link>
          <Link href="/courses/mrcem-sba">MRCEM SBA</Link>
          <Link href="/courses">All Courses</Link>
          <Link href="/app/membership">Membership Offers</Link>
          <Link href="/exams">Exams</Link>
          <Link href="/pricing">Pricing</Link>
        </nav>
        <nav className="footer-column" aria-label={brand.name}>
          <h3>{brand.name}</h3>
          <Link href="/about">About us</Link><Link href="/blog">Blog</Link><Link href="/resources">Resources</Link><Link href="/help">Help Centre</Link><Link href="/contact">Contact</Link><Link href="/signup">Create an account</Link>
        </nav>
        <nav className="footer-column" aria-label="Legal">
          <h3>Legal</h3>
          {legalLinks.map((link) => <Link key={link.href} href={link.href}>{link.label}</Link>)}
          <button type="button" className="footer-link-button" onClick={openCookieSettings}>Cookie settings</button>
        </nav>
        <address className="footer-column footer-contact">
          <h3>Contact</h3>
          {brand.supportEmail && <a href={`mailto:${brand.supportEmail}`}><Mail size={15} aria-hidden="true" />{brand.supportEmail}</a>}
          {brand.phone && <a href={`tel:${brand.phone.replace(/\s/g, '')}`}><Phone size={15} aria-hidden="true" />{brand.phone}</a>}
          {brand.address && <span><MapPin size={15} aria-hidden="true" />{brand.address}</span>}
        </address>
      </div>
      <div className="footer-bottom"><span>© {new Date().getFullYear()} {brand.name}. All rights reserved.</span><span>Designed for the next generation of emergency clinicians.</span></div>
      <p className="footer-disclaimer">{brand.legalDisclaimer}</p>
    </div>
  </footer>;
}
