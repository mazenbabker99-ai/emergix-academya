import { Fragment } from 'react';
import { Link } from 'wouter';
import { AlertCircle, BookOpen, Lightbulb, Sparkles } from 'lucide-react';
import { parseBlocks, type Inline } from '@/lib/prose';

const calloutStyles = {
  tip: {
    bg: '#f0fdf4',
    border: '#86efac',
    iconColor: '#16a34a',
    titleColor: '#166534',
    Icon: Lightbulb,
    defaultTitle: 'Examiner Pearl / High Yield',
  },
  note: {
    bg: '#eff6ff',
    border: '#93c5fd',
    iconColor: '#2563eb',
    titleColor: '#1e40af',
    Icon: BookOpen,
    defaultTitle: 'Clinical Note / Mnemonic',
  },
  warning: {
    bg: '#fffbeb',
    border: '#fcd34d',
    iconColor: '#d97706',
    titleColor: '#92400e',
    Icon: AlertCircle,
    defaultTitle: 'Clinical Warning / Caution',
  },
  info: {
    bg: '#f8fafc',
    border: '#cbd5e1',
    iconColor: '#475569',
    titleColor: '#1e293b',
    Icon: BookOpen,
    defaultTitle: 'Note',
  },
};

function renderInline(nodes: Inline[]) {
  return nodes.map((node, i) => {
    switch (node.type) {
      case 'text':
        return <Fragment key={i}>{node.text}</Fragment>;
      case 'bold':
        return (
          <strong key={i} style={{ color: '#0a2342', fontWeight: 750 }}>
            {renderInline(node.children)}
          </strong>
        );
      case 'em':
        return <em key={i}>{renderInline(node.children)}</em>;
      case 'link':
        return node.href.startsWith('/') ? (
          <Link key={i} href={node.href} style={{ color: '#0066cc', fontWeight: 650, textDecoration: 'underline' }}>
            {renderInline(node.children)}
          </Link>
        ) : (
          <a
            key={i}
            href={node.href}
            target="_blank"
            rel="noopener noreferrer"
            style={{ color: '#0066cc', fontWeight: 650, textDecoration: 'underline' }}
          >
            {renderInline(node.children)}
            <span className="sr-only"> (opens in a new tab)</span>
          </a>
        );
    }
  });
}

interface ProseProps {
  text: string;
  className?: string;
  fontSize?: 'normal' | 'large' | 'xlarge' | 'default';
}

/** Renders admin-edited mini-markdown (see lib/prose.ts) with React elements only. */
export function Prose({ text, className = '', fontSize = 'default' }: ProseProps) {
  // Map font size prop to rem
  const bodyFontSize =
    fontSize === 'xlarge' ? '1.38rem' :
    fontSize === 'large' ? '1.24rem' : '1.125rem';

  const bodyLineHeight =
    fontSize === 'xlarge' ? '1.95' :
    fontSize === 'large' ? '1.9' : '1.85';

  return (
    <div
      className={`prose-lite ${className}`.trim()}
      style={{
        fontSize: bodyFontSize,
        lineHeight: bodyLineHeight,
        color: '#1e293b',
        letterSpacing: '-0.007em',
      }}
    >
      {parseBlocks(text).map((block, i) => {
        switch (block.type) {
          case 'h1':
            return (
              <h1
                key={i}
                style={{
                  fontSize: '2rem',
                  fontWeight: 850,
                  marginTop: '2.4rem',
                  marginBottom: '1.2rem',
                  color: '#0a2342',
                  letterSpacing: '-0.03em',
                  lineHeight: 1.25,
                  borderBottom: '2px solid #e2e8f0',
                  paddingBottom: '12px',
                }}
              >
                {block.text}
              </h1>
            );

          case 'h2':
            return (
              <h2
                key={i}
                style={{
                  fontSize: '1.55rem',
                  fontWeight: 800,
                  marginTop: '2.6rem',
                  marginBottom: '1rem',
                  color: '#0a2342',
                  letterSpacing: '-0.025em',
                  lineHeight: 1.35,
                  display: 'flex',
                  alignItems: 'center',
                  gap: '12px',
                }}
              >
                <span
                  style={{
                    width: '5px',
                    height: '24px',
                    background: '#0066cc',
                    borderRadius: '4px',
                    display: 'inline-block',
                    flexShrink: 0,
                  }}
                />
                {block.text}
              </h2>
            );

          case 'h3':
            if (block.stepNumber) {
              return (
                <div
                  key={i}
                  style={{
                    marginTop: '2.4rem',
                    marginBottom: '1.1rem',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '14px',
                    padding: '12px 18px',
                    background: 'linear-gradient(135deg, #f8fafc 0%, #eff6ff 100%)',
                    borderRadius: '12px',
                    border: '1.5px solid #dbeafe',
                    boxShadow: '0 2px 8px rgba(0, 102, 204, 0.04)',
                  }}
                >
                  <span
                    style={{
                      width: '36px',
                      height: '36px',
                      borderRadius: '50%',
                      background: 'linear-gradient(135deg, #0066cc 0%, #0a2342 100%)',
                      color: '#ffffff',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      fontWeight: 850,
                      fontSize: '1rem',
                      flexShrink: 0,
                      boxShadow: '0 3px 8px rgba(0, 102, 204, 0.35)',
                    }}
                  >
                    {block.stepNumber}
                  </span>
                  <h3
                    style={{
                      fontSize: '1.35rem',
                      fontWeight: 800,
                      color: '#0a2342',
                      margin: 0,
                      letterSpacing: '-0.02em',
                    }}
                  >
                    {block.text}
                  </h3>
                </div>
              );
            }
            return (
              <h3
                key={i}
                style={{
                  fontSize: '1.3rem',
                  fontWeight: 750,
                  marginTop: '2rem',
                  marginBottom: '0.8rem',
                  color: '#0a2342',
                  letterSpacing: '-0.015em',
                  lineHeight: 1.4,
                }}
              >
                {block.text}
              </h3>
            );

          case 'h4':
            return (
              <div
                key={i}
                style={{
                  marginTop: '1.8rem',
                  marginBottom: '0.8rem',
                  display: 'inline-flex',
                  alignItems: 'center',
                  gap: '8px',
                  background: '#eff6ff',
                  border: '1.5px solid #bfdbfe',
                  color: '#1d4ed8',
                  padding: '6px 14px',
                  borderRadius: '8px',
                  fontWeight: 800,
                  fontSize: '0.92rem',
                  letterSpacing: '0.03em',
                  boxShadow: '0 2px 6px rgba(37, 99, 235, 0.08)',
                }}
              >
                <Sparkles size={14} />
                {block.text}
              </div>
            );

          case 'p':
            return (
              <p
                key={i}
                style={{
                  fontSize: bodyFontSize,
                  lineHeight: bodyLineHeight,
                  color: '#1e293b',
                  marginBottom: '1.35rem',
                }}
              >
                {renderInline(block.inline)}
              </p>
            );

          case 'ul':
            return (
              <ul
                key={i}
                style={{
                  fontSize: bodyFontSize,
                  lineHeight: bodyLineHeight,
                  color: '#1e293b',
                  paddingLeft: '28px',
                  marginBottom: '1.4rem',
                }}
              >
                {block.items.map((item, j) => (
                  <li key={j} style={{ marginBottom: '8px' }}>
                    {renderInline(item)}
                  </li>
                ))}
              </ul>
            );

          case 'blockquote':
            return (
              <blockquote
                key={i}
                style={{
                  borderLeft: '4px solid #0066cc',
                  paddingLeft: '20px',
                  margin: '24px 0',
                  color: '#334155',
                  fontStyle: 'italic',
                  background: '#f8fafc',
                  padding: '16px 22px',
                  borderRadius: '0 10px 10px 0',
                  borderTop: '1px solid #f1f5f9',
                  borderRight: '1px solid #f1f5f9',
                  borderBottom: '1px solid #f1f5f9',
                  fontSize: bodyFontSize,
                  lineHeight: bodyLineHeight,
                }}
              >
                {renderInline(block.inline)}
              </blockquote>
            );

          case 'image':
            return (
              <figure key={i} style={{ margin: '36px 0', textAlign: 'center' }}>
                <div
                  style={{
                    maxWidth: '100%',
                    borderRadius: '16px',
                    overflow: 'hidden',
                    border: '1px solid #cbd5e1',
                    boxShadow: '0 8px 30px rgba(10, 35, 66, 0.09)',
                    background: '#ffffff',
                    display: 'inline-block',
                    padding: '12px',
                  }}
                >
                  <img
                    src={block.src}
                    alt={block.alt || 'Clinical Illustration'}
                    loading="lazy"
                    style={{
                      maxWidth: '100%',
                      height: 'auto',
                      display: 'block',
                      maxHeight: '620px',
                      objectFit: 'contain',
                      margin: '0 auto',
                      borderRadius: '10px',
                    }}
                  />
                </div>
                {block.caption && (
                  <figcaption
                    style={{
                      marginTop: '12px',
                      fontSize: '0.92rem',
                      color: '#475569',
                      fontWeight: 650,
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      gap: '8px',
                    }}
                  >
                    <span>📷</span> {block.caption}
                  </figcaption>
                )}
              </figure>
            );

          case 'callout': {
            const style = calloutStyles[block.variant] || calloutStyles.tip;
            const Icon = style.Icon;
            return (
              <aside
                key={i}
                role="note"
                style={{
                  background: style.bg,
                  border: `1.5px solid ${style.border}`,
                  borderLeft: `6px solid ${style.iconColor}`,
                  borderRadius: '12px',
                  padding: '20px 24px',
                  margin: '28px 0',
                  boxShadow: '0 4px 14px rgba(0,0,0,0.04)',
                }}
              >
                <div style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '10px' }}>
                  <Icon size={20} color={style.iconColor} />
                  <strong style={{ color: style.titleColor, fontSize: '1.02rem', letterSpacing: '.01em', fontWeight: 800 }}>
                    {block.title || style.defaultTitle}
                  </strong>
                </div>
                <div style={{ fontSize: bodyFontSize, lineHeight: bodyLineHeight, color: '#1e293b' }}>
                  {renderInline(block.inline)}
                </div>
              </aside>
            );
          }
        }
      })}
    </div>
  );
}
