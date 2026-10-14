import { useEffect, useState, type ReactNode } from 'react';
import { Link, useLocation } from 'wouter';
import { BookOpen, HelpCircle, Menu, ShieldCheck, UserRound, X } from 'lucide-react';
import { Brand } from '@/components/shared/Brand';
import { Footer } from '@/components/shared/Footer';
import { useAuth } from '@/features/auth/AuthProvider';

export interface ShellNavItem {
  href: string;
  label: string;
}

const navIcons: Record<string, typeof BookOpen> = {
  '/admin': BookOpen,
  '/admin/access': ShieldCheck,
  '/admin/questions': HelpCircle,
  '/app': UserRound,
};

/** Signed-in chrome shared by the learner area and the admin area. */
export function ShellLayout({ nav, area, children }: { nav: ShellNavItem[]; area: string; children: ReactNode }) {
  const { user, signOut } = useAuth();
  const [location, navigate] = useLocation();
  const [open, setOpen] = useState(false);

  useEffect(() => {
    setOpen(false);
  }, [location]);

  return (
    <>
      <header className="site-header shell-header">
        <div className="container header-inner">
          <Brand />
          <nav className="nav-links" aria-label={`${area} navigation`}>
            {nav.map((item) => (
              <Link
                key={item.href}
                href={item.href}
                aria-current={location === item.href || (item.href !== '/app' && location.startsWith(`${item.href}/`)) ? 'page' : undefined}
              >
                {item.label}
              </Link>
            ))}
          </nav>
          <div className="nav-actions">
            <span className="shell-user" title={user?.email}>{user?.name}</span>
            <button
              type="button"
              className="btn btn-ghost"
              onClick={async () => {
                await signOut();
                navigate('/');
              }}
            >
              Sign out
            </button>
          </div>
          <button
            className="menu-toggle"
            type="button"
            aria-label={open ? 'Close navigation' : 'Open navigation'}
            aria-expanded={open}
            onClick={() => setOpen((v) => !v)}
          >
            {open ? <X size={24} /> : <Menu size={24} />}
          </button>
        </div>
        {open && (
          <nav className="mobile-nav" aria-label={`Mobile ${area} navigation`}>
            {nav.map((item) => (
              <Link key={item.href} href={item.href}>
                {item.label}
              </Link>
            ))}
            <div style={{ padding: '12px 4px', borderTop: '1px solid rgba(255,255,255,0.15)', marginTop: 8 }}>
              <span style={{ color: '#94a3b8', fontSize: '.84rem', display: 'block', marginBottom: 8 }}>
                Signed in as: <strong style={{ color: '#fff' }}>{user?.name}</strong>
              </span>
              <button
                type="button"
                className="btn btn-primary"
                style={{ width: '100%' }}
                onClick={async () => {
                  await signOut();
                  navigate('/');
                }}
              >
                Sign out
              </button>
            </div>
          </nav>
        )}
      </header>

      {/* Prominent Admin Navigation Tab Strip - visible on mobile and desktop */}
      {area === 'Admin' && (
        <div
          className="admin-subnav-strip"
          style={{
            background: '#fff',
            borderBottom: '1px solid #dce8f5',
            padding: '4px 0',
            position: 'sticky',
            top: 66,
            zIndex: 40,
            boxShadow: '0 2px 6px rgba(10,35,66,.04)',
          }}
        >
          <div
            className="container"
            style={{
              display: 'flex',
              gap: 8,
              alignItems: 'center',
              overflowX: 'auto',
              padding: '4px 16px',
              scrollbarWidth: 'none',
            }}
          >
            {nav.map((item) => {
              const isActive = location === item.href || (item.href !== '/admin' && item.href !== '/app' && location.startsWith(`${item.href}/`));
              const Icon = navIcons[item.href] || BookOpen;
              return (
                <Link
                  key={item.href}
                  href={item.href}
                  style={{
                    display: 'inline-flex',
                    alignItems: 'center',
                    gap: 7,
                    padding: '8px 14px',
                    borderRadius: 8,
                    fontSize: '.85rem',
                    fontWeight: 700,
                    textDecoration: 'none',
                    whiteSpace: 'nowrap',
                    color: isActive ? '#0066CC' : '#475569',
                    background: isActive ? '#e8f3ff' : 'transparent',
                    border: isActive ? '1px solid #b8daff' : '1px solid transparent',
                    transition: 'all .15s',
                  }}
                >
                  <Icon size={16} color={isActive ? '#0066CC' : '#64748b'} />
                  <span>{item.label}</span>
                </Link>
              );
            })}
          </div>
        </div>
      )}

      <main className="shell-main container" id="main">{children}</main>
      <Footer />
    </>
  );
}
