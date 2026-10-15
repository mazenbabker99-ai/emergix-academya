import { Link } from 'wouter';
import { brand } from '@/config/brand';

function BrandIcon({ size = 28, light = false }: { size?: number; light?: boolean }) {
  return (
    <svg width={size} height={size} viewBox="0 0 180 180" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
      <defs>
        <linearGradient id="b-bg" x1="0%" y1="0%" x2="100%" y2="100%">
          <stop offset="0%" stopColor={light ? '#1a4a7a' : '#071A32'} />
          <stop offset="100%" stopColor={light ? '#0a3060' : '#0F3868'} />
        </linearGradient>
        <linearGradient id="b-shield" x1="0%" y1="0%" x2="100%" y2="100%">
          <stop offset="0%" stopColor="#0066CC" />
          <stop offset="100%" stopColor="#0A2342" />
        </linearGradient>
        <linearGradient id="b-pulse" x1="0%" y1="0%" x2="100%" y2="100%">
          <stop offset="0%" stopColor="#38BDF8" />
          <stop offset="100%" stopColor="#0066CC" />
        </linearGradient>
      </defs>
      <rect width="180" height="180" rx="36" fill="url(#b-bg)" />
      <path d="M90 28L40 48.5V90C40 126 65 149 90 156C115 149 140 126 140 90V48.5L90 28Z" fill="url(#b-shield)" stroke="#38BDF8" strokeWidth="2.5" strokeLinejoin="round" />
      <path d="M90 56V124M56 90H124" stroke="rgba(255,255,255,0.15)" strokeWidth="5" strokeLinecap="round" />
      <path d="M50 90H74L82 66L95 114L105 78L113 90H130" stroke="url(#b-pulse)" strokeWidth="5" strokeLinecap="round" strokeLinejoin="round" />
      <circle cx="90" cy="52" r="4.5" fill="#38BDF8" />
    </svg>
  );
}

export function Brand({ light = false }: { light?: boolean }) {
  const [first, ...rest] = brand.nameParts;
  return <Link href="/" className="brand" aria-label={`${brand.name} home`} style={light ? { color: 'white' } : undefined}>
    <span className="brand-mark"><BrandIcon size={28} light={light} /></span>
    <span className="brand-lockup"><span className="brand-word"><span>{first}</span>{rest.length > 0 && <> <i>{rest.join(' ')}</i></>}</span><small>{brand.tagline}</small></span>
  </Link>;
}
