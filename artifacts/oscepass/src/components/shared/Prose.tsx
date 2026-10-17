import { Fragment } from 'react';
import { Link } from 'wouter';
import { AlertCircle, BookOpen, Lightbulb } from 'lucide-react';
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
        return <strong key={i}>{renderInline(node.children)}</strong>;
      case 'em':
        return <em key={i}>{renderInline(node.children)}</em>;
      case 'link':
        return node.href.startsWith('/') ? (
          <Link key={i} href={node.href}>{renderInline(node.children)}</Link>
        ) : (
          <a key={i} href={node.href} target="_blank" rel="noopener noreferrer">
            {renderInline(node.children)}
            <span className="sr-only"> (opens in a new tab)</span>
          </a>
        );
    }
  });
}

/** Renders admin-edited mini-markdown (see lib/prose.ts) with React elements only. */
export function Prose({ text, className = '' }: { text: string; className?: string }) {
  return (
    <div className={`prose-lite ${className}`.trim()}>
      {parseBlocks(text).map((block, i) => {
        switch (block.type) {
          case 'h1':
            return <h1 key={i} style={{ fontSize: '1.75rem', fontWeight: 800, marginTop: '1.6rem', marginBottom: '1rem', color: '#0a2342' }}>{block.text}</h1>;
          case 'h2':
            return <h2 key={i}>{block.text}</h2>;
          case 'h3':
            return <h3 key={i}>{block.text}</h3>;
          case 'p':
            return <p key={i}>{renderInline(block.inline)}</p>;
          case 'ul':
            return <ul key={i}>{block.items.map((item, j) => <li key={j}>{renderInline(item)}</li>)}</ul>;
          case 'blockquote':
            return (
              <blockquote
                key={i}
                style={{
                  borderLeft: '4px solid #0066CC',
                  paddingLeft: '16px',
                  margin: '20px 0',
                  color: '#334155',
                  fontStyle: 'italic',
                  background: '#f8fafc',
                  padding: '12px 18px',
                  borderRadius: '0 8px 8px 0',
                }}
              >
                {renderInline(block.inline)}
              </blockquote>
            );
          case 'image':
            return (
              <figure key={i} style={{ margin: '28px 0', textAlign: 'center' }}>
                <div
                  style={{
                    maxWidth: '100%',
                    borderRadius: '12px',
                    overflow: 'hidden',
                    border: '1px solid #e2e8f0',
                    boxShadow: '0 4px 20px rgba(10, 35, 66, 0.08)',
                    background: '#ffffff',
                    display: 'inline-block',
                    padding: '8px',
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
                      maxHeight: '580px',
                      objectFit: 'contain',
                      margin: '0 auto',
                      borderRadius: '8px',
                    }}
                  />
                </div>
                {block.caption && (
                  <figcaption
                    style={{
                      marginTop: '10px',
                      fontSize: '0.86rem',
                      color: '#475569',
                      fontWeight: 600,
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      gap: '6px',
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
                  border: `1px solid ${style.border}`,
                  borderLeft: `5px solid ${style.iconColor}`,
                  borderRadius: '8px',
                  padding: '16px 20px',
                  margin: '24px 0',
                  boxShadow: '0 2px 8px rgba(0,0,0,0.03)',
                }}
              >
                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '8px' }}>
                  <Icon size={18} color={style.iconColor} />
                  <strong style={{ color: style.titleColor, fontSize: '.92rem', letterSpacing: '.01em' }}>
                    {block.title || style.defaultTitle}
                  </strong>
                </div>
                <div style={{ fontSize: '.95rem', lineHeight: '1.65', color: '#1e293b' }}>
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
