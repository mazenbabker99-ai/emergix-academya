/**
 * Tiny, safe markdown subset used by admin-edited content (exam text, FAQ answers, legal pages, blog).
 * Supports: ## / ### headings, "- " bullet lists, paragraphs, **bold**, *italic*, [text](url).
 * Output is a plain data structure rendered with React elements (never dangerouslySetInnerHTML).
 */
export type Inline =
  | { type: 'text'; text: string }
  | { type: 'bold'; children: Inline[] }
  | { type: 'em'; children: Inline[] }
  | { type: 'link'; href: string; children: Inline[] };

export type Block =
  | { type: 'h1' | 'h2' | 'h3'; text: string }
  | { type: 'callout'; variant: 'tip' | 'note' | 'warning' | 'info'; title?: string; inline: Inline[] }
  | { type: 'blockquote'; inline: Inline[] }
  | { type: 'image'; src: string; alt: string; caption?: string }
  | { type: 'p'; inline: Inline[] }
  | { type: 'ul'; items: Inline[][] };

/** Only http(s), mailto and site-relative links are allowed; anything else (javascript:, data:) is dropped. */
export function safeHref(url: string): string | null {
  const value = url.trim();
  if (/^https?:\/\//i.test(value) || /^mailto:/i.test(value)) return value;
  if (value.startsWith('/') && !value.startsWith('//')) return value;
  return null;
}

const TOKEN = /\*\*(.+?)\*\*|\*(.+?)\*|\[([^\]]+)\]\(([^)\s]+)\)/g;

export function parseInline(src: string): Inline[] {
  const out: Inline[] = [];
  let last = 0;
  for (const match of src.matchAll(TOKEN)) {
    const index = match.index ?? 0;
    if (index > last) out.push({ type: 'text', text: src.slice(last, index) });
    if (match[1] !== undefined) out.push({ type: 'bold', children: parseInline(match[1]) });
    else if (match[2] !== undefined) out.push({ type: 'em', children: parseInline(match[2]) });
    else {
      const href = safeHref(match[4] ?? '');
      out.push(href ? { type: 'link', href, children: parseInline(match[3] ?? '') } : { type: 'text', text: match[3] ?? '' });
    }
    last = index + match[0].length;
  }
  if (last < src.length) out.push({ type: 'text', text: src.slice(last) });
  return out;
}

export function parseBlocks(src: string): Block[] {
  const blocks: Block[] = [];
  let paragraph: string[] = [];
  let list: Inline[][] | null = null;
  let quoteLines: string[] = [];

  const flushQuote = () => {
    if (!quoteLines.length) return;
    const first = quoteLines[0] || '';
    const tipMatch = first.match(/^\[!(TIP|NOTE|WARNING|IMPORTANT|CAUTION)\]/i);
    if (tipMatch) {
      const rawVariant = tipMatch[1].toLowerCase();
      const variant: 'tip' | 'note' | 'warning' | 'info' =
        rawVariant === 'tip' ? 'tip' :
        rawVariant === 'warning' || rawVariant === 'caution' ? 'warning' : 'note';
      
      const restLines = quoteLines.slice(1);
      let title: string | undefined;
      let contentLines = restLines;
      if (restLines.length > 0 && restLines[0].startsWith('**') && restLines[0].endsWith('**')) {
        title = restLines[0].slice(2, -2).trim();
        contentLines = restLines.slice(1);
      }
      blocks.push({
        type: 'callout',
        variant,
        title,
        inline: parseInline(contentLines.join(' ')),
      });
    } else {
      blocks.push({
        type: 'blockquote',
        inline: parseInline(quoteLines.join(' ')),
      });
    }
    quoteLines = [];
  };

  const flush = () => {
    if (paragraph.length) blocks.push({ type: 'p', inline: parseInline(paragraph.join(' ')) });
    if (list) blocks.push({ type: 'ul', items: list });
    flushQuote();
    paragraph = [];
    list = null;
  };

  for (const raw of src.replace(/\r\n?/g, '\n').split('\n')) {
    const line = raw.trim();
    if (!line) {
      flush();
    } else if (line.startsWith('> ') || line === '>') {
      if (paragraph.length) flush();
      if (list) flush();
      quoteLines.push(line.replace(/^>\s?/, ''));
    } else if (/^!\[([^\]]*)\]\(([^)\s]+)(?:\s+"([^"]*)")?\)$/.test(line)) {
      flush();
      const imgMatch = line.match(/^!\[([^\]]*)\]\(([^)\s]+)(?:\s+"([^"]*)")?\)$/);
      if (imgMatch) {
        const alt = imgMatch[1] || 'Clinical Illustration';
        const rawSrc = imgMatch[2];
        const caption = imgMatch[3] || alt;
        const src = safeHref(rawSrc) || rawSrc;
        blocks.push({ type: 'image', src, alt, caption });
      }
    } else if (
      line.startsWith('*') &&
      line.endsWith('*') &&
      !line.startsWith('**') &&
      blocks.length > 0 &&
      blocks[blocks.length - 1].type === 'image'
    ) {
      const imgBlock = blocks[blocks.length - 1] as { type: 'image'; src: string; alt: string; caption?: string };
      imgBlock.caption = line.slice(1, -1).trim();
    } else if (line.startsWith('### ')) {
      flush();
      blocks.push({ type: 'h3', text: line.slice(4).trim() });
    } else if (line.startsWith('## ')) {
      flush();
      blocks.push({ type: 'h2', text: line.slice(3).trim() });
    } else if (line.startsWith('# ')) {
      flush();
      blocks.push({ type: 'h1', text: line.slice(2).trim() });
    } else if (line.startsWith('- ')) {
      if (paragraph.length) flush();
      flushQuote();
      (list ??= []).push(parseInline(line.slice(2).trim()));
    } else {
      if (list) flush();
      flushQuote();
      paragraph.push(line);
    }
  }
  flush();
  return blocks;
}

/** Plain text (no markup) for JSON-LD and meta descriptions. */
export function stripMarkdown(src: string): string {
  return src
    .replace(/!\[([^\]]*)\]\([^)]*\)/g, '')
    .replace(/\[([^\]]+)\]\([^)]*\)/g, '$1')
    .replace(/\*\*(.+?)\*\*/g, '$1')
    .replace(/\*(.+?)\*/g, '$1')
    .replace(/^#{1,3}\s+/gm, '')
    .replace(/^-\s+/gm, '')
    .replace(/\s+/g, ' ')
    .trim();
}
