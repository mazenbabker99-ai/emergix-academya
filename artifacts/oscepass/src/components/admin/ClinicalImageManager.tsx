import React, { useState, useEffect, useMemo, useRef } from 'react';
import {
  Image as ImageIcon,
  Plus,
  Trash2,
  ZoomIn,
  Upload,
  Link2,
  BookOpen,
  X,
  Check,
  AlertCircle,
  Loader2,
  ArrowUp,
  ArrowDown,
  ChevronsUp,
  ChevronsDown,
  Layers,
} from 'lucide-react';

export interface ExtractedImage {
  id: string;
  alt: string;
  src: string;
  caption?: string;
  rawMatch: string;
}

export type InsertPlacement = 'auto' | 'before-question' | 'top' | 'bottom';

export function parseImagesFromMarkdown(text: string): ExtractedImage[] {
  if (!text) return [];
  const regex = /!\[([^\]]*)\]\(([^)\s]+)(?:\s+"([^"]*)")?\)(?:\s*(?:\r?\n)+\s*\*([^*]+)\*)?/g;
  const results: ExtractedImage[] = [];
  let match: RegExpExecArray | null;
  let idx = 0;
  while ((match = regex.exec(text)) !== null) {
    idx++;
    results.push({
      id: `img-${idx}-${match.index}`,
      alt: match[1]?.trim() || 'Clinical Figure',
      src: match[2]?.trim(),
      caption: match[4]?.trim() || match[3]?.trim() || match[1]?.trim() || 'Clinical Figure',
      rawMatch: match[0],
    });
  }
  return results;
}

export function removeImageFromMarkdown(text: string, rawMatch: string): string {
  const cleaned = text.replace(rawMatch, '');
  return cleaned.replace(/\n{3,}/g, '\n\n').trim();
}

export function insertImageWithPlacement(
  text: string,
  src: string,
  alt: string,
  placement: InsertPlacement = 'auto',
): string {
  const cleanAlt = alt.trim() || 'Clinical Figure';
  const tag = `![${cleanAlt}](${src.trim()})\n*${cleanAlt}*`;

  if (!text || !text.trim()) return tag;

  if (placement === 'top') {
    return `${tag}\n\n${text.trimStart()}`;
  }

  if (placement === 'before-question' || placement === 'auto') {
    const qMatch = text.match(/(?:(?:\r?\n)+\s*|\.\s+)(Which|What|How|Who|Why|Where|Select|Identify|Choose)[^?]*\?/i);
    if (qMatch && qMatch.index !== undefined) {
      const idx = qMatch.index + (qMatch[0].startsWith('.') ? 1 : 0);
      return `${text.slice(0, idx).trimEnd()}\n\n${tag}\n\n${text.slice(idx).trimStart()}`;
    }
  }

  // Default: Bottom
  return `${text.trimEnd()}\n\n${tag}\n`;
}

export function moveImageInText(
  text: string,
  rawMatch: string,
  direction: 'up' | 'down' | 'top' | 'bottom',
): string {
  const cleanRaw = rawMatch.trim();
  const paragraphs = text.replace(/\r\n/g, '\n').split(/\n{2,}/).map((p) => p.trim()).filter(Boolean);
  const imgIdx = paragraphs.findIndex((p) => p.includes(cleanRaw));
  if (imgIdx === -1) return text;

  const isolatedList: string[] = [];
  paragraphs.forEach((p, i) => {
    if (i === imgIdx) {
      const parts = p.split(cleanRaw).map((s) => s.trim()).filter(Boolean);
      if (parts.length === 0) {
        isolatedList.push(cleanRaw);
      } else if (p.startsWith(cleanRaw)) {
        isolatedList.push(cleanRaw);
        isolatedList.push(parts[0]);
      } else {
        isolatedList.push(parts[0]);
        isolatedList.push(cleanRaw);
        if (parts[1]) isolatedList.push(parts[1]);
      }
    } else {
      isolatedList.push(p);
    }
  });

  const tagIdx = isolatedList.findIndex((item) => item === cleanRaw);
  if (tagIdx === -1) return text;

  if (direction === 'top') {
    const [item] = isolatedList.splice(tagIdx, 1);
    isolatedList.unshift(item);
  } else if (direction === 'bottom') {
    const [item] = isolatedList.splice(tagIdx, 1);
    isolatedList.push(item);
  } else if (direction === 'up' && tagIdx > 0) {
    [isolatedList[tagIdx - 1], isolatedList[tagIdx]] = [isolatedList[tagIdx], isolatedList[tagIdx - 1]];
  } else if (direction === 'down' && tagIdx < isolatedList.length - 1) {
    [isolatedList[tagIdx + 1], isolatedList[tagIdx]] = [isolatedList[tagIdx], isolatedList[tagIdx + 1]];
  }

  return isolatedList.join('\n\n');
}

export function getImagePositionInfo(text: string, rawMatch: string): { current: number; total: number; label: string; isTop: boolean; isBottom: boolean } {
  const cleanRaw = rawMatch.trim();
  const paragraphs = text.replace(/\r\n/g, '\n').split(/\n{2,}/).map((p) => p.trim()).filter(Boolean);
  const idx = paragraphs.findIndex((p) => p.includes(cleanRaw));
  if (idx === -1) return { current: 1, total: 1, label: 'Single position', isTop: true, isBottom: true };

  const total = paragraphs.length;
  const current = idx + 1;
  const isTop = current === 1;
  const isBottom = current === total;

  let label = `Position: Paragraph ${current} of ${total}`;
  if (isTop) label = 'Position: Top (البداية)';
  else if (isBottom) label = 'Position: End (النهاية)';
  else label = `Position: Middle (${current}/${total})`;

  return { current, total, label, isTop, isBottom };
}

interface LibraryItem {
  category: string;
  topic: string;
  filename: string;
  webPath: string;
  title: string;
}

interface ClinicalImageManagerProps {
  text: string;
  onChange: (newText: string) => void;
  label?: string;
  compact?: boolean;
}

export const ClinicalImageManager: React.FC<ClinicalImageManagerProps> = ({
  text,
  onChange,
  label = 'Clinical Figures',
  compact = false,
}) => {
  const [isAddModalOpen, setIsAddModalOpen] = useState(false);
  const [zoomImage, setZoomImage] = useState<ExtractedImage | null>(null);
  const [activeTab, setActiveTab] = useState<'url' | 'upload' | 'library'>('url');
  const [selectedPlacement, setSelectedPlacement] = useState<InsertPlacement>('auto');

  // Form states for adding image
  const [inputUrl, setInputUrl] = useState('');
  const [inputCaption, setInputCaption] = useState('');
  const [urlStatus, setUrlStatus] = useState<'idle' | 'loading' | 'valid' | 'invalid'>('idle');

  // Upload states
  const [selectedFile, setSelectedFile] = useState<File | null>(null);
  const [filePreview, setFilePreview] = useState<string | null>(null);
  const [uploadLoading, setUploadLoading] = useState(false);
  const [uploadError, setUploadError] = useState('');
  const fileInputRef = useRef<HTMLInputElement>(null);

  // Library states
  const [libraryItems, setLibraryItems] = useState<LibraryItem[]>([]);
  const [libraryLoading, setLibraryLoading] = useState(false);
  const [selectedCategory, setSelectedCategory] = useState<string>('all');
  const [librarySearch, setLibrarySearch] = useState('');
  const [selectedLibraryItem, setSelectedLibraryItem] = useState<LibraryItem | null>(null);

  // Extracted images from current markdown
  const extractedImages = useMemo(() => parseImagesFromMarkdown(text), [text]);

  // Test URL when input changes
  useEffect(() => {
    if (!inputUrl.trim()) {
      setUrlStatus('idle');
      return;
    }
    setUrlStatus('loading');
    const img = new Image();
    img.onload = () => setUrlStatus('valid');
    img.onerror = () => setUrlStatus('invalid');
    img.src = inputUrl.trim();
  }, [inputUrl]);

  // Fetch library items on demand
  useEffect(() => {
    if (activeTab === 'library' && libraryItems.length === 0 && !libraryLoading) {
      setLibraryLoading(true);
      fetch('/lessons/images/sba/image_manifest.json')
        .then((res) => (res.ok ? res.json() : null))
        .then((data) => {
          if (!data) return;
          const items: LibraryItem[] = [];
          for (const [key, figures] of Object.entries(data)) {
            const [cat, topic] = key.split('/');
            if (Array.isArray(figures)) {
              for (const fig of figures as any[]) {
                const formattedTopic = (topic || cat).replace(/-/g, ' ');
                items.push({
                  category: cat,
                  topic: topic || cat,
                  filename: fig.filename,
                  webPath: fig.web_path,
                  title: `${formattedTopic.charAt(0).toUpperCase() + formattedTopic.slice(1)} - ${fig.filename.replace(/\.[^/.]+$/, '')}`,
                });
              }
            }
          }
          setLibraryItems(items);
        })
        .catch(() => {})
        .finally(() => setLibraryLoading(false));
    }
  }, [activeTab, libraryItems.length, libraryLoading]);

  // Handle position movement
  const handleMoveImage = (img: ExtractedImage, direction: 'up' | 'down' | 'top' | 'bottom') => {
    const updated = moveImageInText(text, img.rawMatch, direction);
    onChange(updated);
  };

  // Handle image removal
  const handleDeleteImage = (img: ExtractedImage) => {
    if (window.confirm(`Are you sure you want to remove "${img.alt || 'this image'}" from the lesson?`)) {
      const updated = removeImageFromMarkdown(text, img.rawMatch);
      onChange(updated);
    }
  };

  // Handle direct URL insertion
  const handleInsertUrl = () => {
    if (!inputUrl.trim()) return;
    const caption = inputCaption.trim() || 'Clinical Figure';
    const updated = insertImageWithPlacement(text, inputUrl.trim(), caption, selectedPlacement);
    onChange(updated);
    setIsAddModalOpen(false);
    resetModal();
  };

  // Handle local file selection
  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;
    setSelectedFile(file);
    setUploadError('');

    const reader = new FileReader();
    reader.onload = (ev) => {
      setFilePreview(ev.target?.result as string);
    };
    reader.readAsDataURL(file);

    if (!inputCaption) {
      const baseName = file.name.replace(/\.[^/.]+$/, '').replace(/[-_]/g, ' ');
      setInputCaption(`Figure: ${baseName.charAt(0).toUpperCase() + baseName.slice(1)}`);
    }
  };

  // Handle upload to server
  const handleUploadAndInsert = async () => {
    if (!selectedFile || !filePreview) return;
    setUploadLoading(true);
    setUploadError('');

    try {
      const response = await fetch('/api/admin/images/upload', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          filename: selectedFile.name,
          mimeType: selectedFile.type || 'image/jpeg',
          base64Data: filePreview,
          caption: inputCaption.trim() || 'Clinical Figure',
        }),
      });

      if (!response.ok) {
        const errJson = await response.json().catch(() => ({}));
        throw new Error(errJson?.error?.message || `Upload failed with status ${response.status}`);
      }

      const data = await response.json();
      const serverUrl = data.image?.url || filePreview;
      const caption = inputCaption.trim() || selectedFile.name;
      const updated = insertImageWithPlacement(text, serverUrl, caption, selectedPlacement);
      onChange(updated);
      setIsAddModalOpen(false);
      resetModal();
    } catch (err: any) {
      setUploadError(err.message || 'Failed to upload image. Please try again.');
    } finally {
      setUploadLoading(false);
    }
  };

  // Handle library insertion
  const handleInsertFromLibrary = () => {
    if (!selectedLibraryItem) return;
    const caption = inputCaption.trim() || selectedLibraryItem.title;
    const updated = insertImageWithPlacement(text, selectedLibraryItem.webPath, caption, selectedPlacement);
    onChange(updated);
    setIsAddModalOpen(false);
    resetModal();
  };

  const resetModal = () => {
    setInputUrl('');
    setInputCaption('');
    setUrlStatus('idle');
    setSelectedFile(null);
    setFilePreview(null);
    setUploadError('');
    setSelectedLibraryItem(null);
    setSelectedPlacement('auto');
  };

  // Categories from library
  const categories = useMemo(() => {
    const set = new Set<string>();
    libraryItems.forEach((item) => set.add(item.category));
    return ['all', ...Array.from(set)];
  }, [libraryItems]);

  // Filtered library items
  const filteredLibrary = useMemo(() => {
    return libraryItems.filter((item) => {
      const matchesCat = selectedCategory === 'all' || item.category === selectedCategory;
      const matchesSearch =
        !librarySearch.trim() ||
        item.title.toLowerCase().includes(librarySearch.toLowerCase()) ||
        item.topic.toLowerCase().includes(librarySearch.toLowerCase());
      return matchesCat && matchesSearch;
    });
  }, [libraryItems, selectedCategory, librarySearch]);

  return (
    <div style={{ margin: compact ? '4px 0 8px' : '8px 0 14px' }}>
      {/* ─── Top Control Bar ─── */}
      <div
        style={{
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between',
          flexWrap: 'wrap',
          gap: 6,
          padding: '6px 10px',
          background: '#f8fafc',
          border: '1px solid #e2e8f0',
          borderRadius: 6,
          marginBottom: extractedImages.length > 0 ? 8 : 0,
        }}
      >
        <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
          <ImageIcon size={14} style={{ color: '#0d9488' }} />
          <span style={{ fontSize: '0.78rem', fontWeight: 700, color: '#334155' }}>{label}:</span>
          {extractedImages.length > 0 ? (
            <span
              style={{
                fontSize: '0.72rem',
                fontWeight: 700,
                color: '#065f46',
                background: '#d1fae5',
                padding: '1px 7px',
                borderRadius: 10,
              }}
            >
              {extractedImages.length} {extractedImages.length === 1 ? 'figure' : 'figures'} attached
            </span>
          ) : (
            <span style={{ fontSize: '0.72rem', color: '#94a3b8' }}>No figures attached</span>
          )}
        </div>

        <button
          type="button"
          onClick={() => {
            resetModal();
            setIsAddModalOpen(true);
          }}
          style={{
            display: 'inline-flex',
            alignItems: 'center',
            gap: 4,
            padding: '3px 9px',
            fontSize: '0.75rem',
            fontWeight: 700,
            color: '#0f766e',
            background: '#ccfbf1',
            border: '1px solid #99f6e4',
            borderRadius: 5,
            cursor: 'pointer',
            transition: 'all 0.15s ease',
          }}
          onMouseEnter={(e) => {
            e.currentTarget.style.background = '#0d9488';
            e.currentTarget.style.color = '#ffffff';
          }}
          onMouseLeave={(e) => {
            e.currentTarget.style.background = '#ccfbf1';
            e.currentTarget.style.color = '#0f766e';
          }}
        >
          <Plus size={13} strokeWidth={2.5} /> Add Clinical Figure
        </button>
      </div>

      {/* ─── Current Images List with Position Controller & 1-Click Delete ─── */}
      {extractedImages.length > 0 && (
        <div
          style={{
            display: 'grid',
            gridTemplateColumns: 'repeat(auto-fill, minmax(320px, 1fr))',
            gap: 8,
            marginBottom: 6,
          }}
        >
          {extractedImages.map((img, i) => {
            const posInfo = getImagePositionInfo(text, img.rawMatch);
            return (
              <div
                key={img.id || i}
                style={{
                  display: 'flex',
                  alignItems: 'center',
                  gap: 8,
                  padding: '6px 10px',
                  background: '#ffffff',
                  border: '1px solid #cbd5e1',
                  borderRadius: 6,
                  boxShadow: '0 1px 2px rgba(0,0,0,0.04)',
                  position: 'relative',
                }}
              >
                {/* Thumbnail with Zoom Click */}
                <div
                  onClick={() => setZoomImage(img)}
                  title="Click to zoom in"
                  style={{
                    width: 52,
                    height: 48,
                    borderRadius: 4,
                    overflow: 'hidden',
                    background: '#f1f5f9',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    cursor: 'zoom-in',
                    flexShrink: 0,
                    border: '1px solid #e2e8f0',
                  }}
                >
                  <img
                    src={img.src}
                    alt={img.alt}
                    style={{ width: '100%', height: '100%', objectFit: 'cover' }}
                    onError={(e) => {
                      (e.target as HTMLElement).style.display = 'none';
                    }}
                  />
                </div>

                {/* Caption & Position Badge */}
                <div style={{ flex: 1, minWidth: 0 }}>
                  <p
                    style={{
                      margin: 0,
                      fontSize: '0.74rem',
                      fontWeight: 700,
                      color: '#1e293b',
                      whiteSpace: 'nowrap',
                      overflow: 'hidden',
                      textOverflow: 'ellipsis',
                    }}
                    title={img.alt}
                  >
                    {img.alt}
                  </p>
                  <div style={{ display: 'flex', alignItems: 'center', gap: 4, marginTop: 2 }}>
                    <span
                      style={{
                        fontSize: '0.66rem',
                        fontWeight: 700,
                        color: posInfo.isTop ? '#0284c7' : posInfo.isBottom ? '#64748b' : '#059669',
                        background: posInfo.isTop ? '#e0f2fe' : posInfo.isBottom ? '#f1f5f9' : '#ecfdf5',
                        padding: '1px 5px',
                        borderRadius: 4,
                      }}
                    >
                      {posInfo.label}
                    </span>
                  </div>
                </div>

                {/* ─── Position Controls Toolbar (Move Up / Down / Top / Bottom) ─── */}
                <div style={{ display: 'flex', alignItems: 'center', gap: 2, background: '#f8fafc', padding: '2px 4px', borderRadius: 5, border: '1px solid #e2e8f0' }}>
                  <button
                    type="button"
                    onClick={() => handleMoveImage(img, 'up')}
                    disabled={posInfo.isTop}
                    title="Move Up one paragraph (نقل للأعلى فقرة)"
                    style={{
                      background: 'none',
                      border: 'none',
                      padding: '3px 4px',
                      color: posInfo.isTop ? '#cbd5e1' : '#0f766e',
                      cursor: posInfo.isTop ? 'not-allowed' : 'pointer',
                      borderRadius: 3,
                      display: 'flex',
                    }}
                  >
                    <ArrowUp size={13} strokeWidth={2.5} />
                  </button>
                  <button
                    type="button"
                    onClick={() => handleMoveImage(img, 'down')}
                    disabled={posInfo.isBottom}
                    title="Move Down one paragraph (نقل للأسفل فقرة)"
                    style={{
                      background: 'none',
                      border: 'none',
                      padding: '3px 4px',
                      color: posInfo.isBottom ? '#cbd5e1' : '#0f766e',
                      cursor: posInfo.isBottom ? 'not-allowed' : 'pointer',
                      borderRadius: 3,
                      display: 'flex',
                    }}
                  >
                    <ArrowDown size={13} strokeWidth={2.5} />
                  </button>
                  <button
                    type="button"
                    onClick={() => handleMoveImage(img, 'top')}
                    disabled={posInfo.isTop}
                    title="Move to Top of text (نقل لأعلى النص)"
                    style={{
                      background: 'none',
                      border: 'none',
                      padding: '3px 4px',
                      color: posInfo.isTop ? '#cbd5e1' : '#334155',
                      cursor: posInfo.isTop ? 'not-allowed' : 'pointer',
                      borderRadius: 3,
                      display: 'flex',
                    }}
                  >
                    <ChevronsUp size={13} strokeWidth={2.5} />
                  </button>
                  <button
                    type="button"
                    onClick={() => handleMoveImage(img, 'bottom')}
                    disabled={posInfo.isBottom}
                    title="Move to Bottom of text (نقل لأسفل النص)"
                    style={{
                      background: 'none',
                      border: 'none',
                      padding: '3px 4px',
                      color: posInfo.isBottom ? '#cbd5e1' : '#334155',
                      cursor: posInfo.isBottom ? 'not-allowed' : 'pointer',
                      borderRadius: 3,
                      display: 'flex',
                    }}
                  >
                    <ChevronsDown size={13} strokeWidth={2.5} />
                  </button>
                </div>

                {/* Zoom & Delete Buttons */}
                <div style={{ display: 'flex', alignItems: 'center', gap: 2, flexShrink: 0 }}>
                  <button
                    type="button"
                    onClick={() => setZoomImage(img)}
                    title="View full image"
                    style={{
                      background: 'none',
                      border: 'none',
                      padding: 4,
                      color: '#64748b',
                      cursor: 'pointer',
                      borderRadius: 4,
                    }}
                  >
                    <ZoomIn size={14} />
                  </button>
                  <button
                    type="button"
                    onClick={() => handleDeleteImage(img)}
                    title="Delete image from lesson (حذف الصورة بنقرة واحدة)"
                    style={{
                      background: '#fee2e2',
                      border: '1px solid #fecaca',
                      padding: '3px 5px',
                      color: '#dc2626',
                      cursor: 'pointer',
                      borderRadius: 4,
                      display: 'flex',
                      alignItems: 'center',
                    }}
                  >
                    <Trash2 size={13} />
                  </button>
                </div>
              </div>
            );
          })}
        </div>
      )}

      {/* ─── ADD IMAGE MODAL ─── */}
      {isAddModalOpen && (
        <div
          style={{
            position: 'fixed',
            inset: 0,
            background: 'rgba(15, 23, 42, 0.6)',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            zIndex: 99999,
            padding: 16,
          }}
          onMouseDown={(e) => {
            if (e.target === e.currentTarget && !uploadLoading) {
              setIsAddModalOpen(false);
              resetModal();
            }
          }}
        >
          <div
            style={{
              background: '#ffffff',
              borderRadius: 10,
              width: 'min(640px, 96vw)',
              maxHeight: '90vh',
              display: 'flex',
              flexDirection: 'column',
              boxShadow: '0 20px 25px -5px rgba(0, 0, 0, 0.2), 0 8px 10px -6px rgba(0, 0, 0, 0.1)',
              overflow: 'hidden',
            }}
          >
            {/* Modal Header */}
            <div
              style={{
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'space-between',
                padding: '14px 18px',
                borderBottom: '1px solid #e2e8f0',
                background: '#f8fafc',
              }}
            >
              <div>
                <h3 style={{ margin: 0, fontSize: '1rem', fontWeight: 800, color: '#0f172a' }}>
                  Insert Clinical Figure
                </h3>
                <p style={{ margin: '2px 0 0', fontSize: '0.74rem', color: '#64748b' }}>
                  Attach ECGs, radiographs, anatomy diagrams, or clinical photos to your lesson.
                </p>
              </div>
              <button
                type="button"
                onClick={() => {
                  setIsAddModalOpen(false);
                  resetModal();
                }}
                disabled={uploadLoading}
                style={{
                  background: 'none',
                  border: 'none',
                  padding: 4,
                  cursor: 'pointer',
                  color: '#64748b',
                  borderRadius: 4,
                }}
              >
                <X size={18} />
              </button>
            </div>

            {/* Modal Source Tabs */}
            <div
              style={{
                display: 'flex',
                borderBottom: '1px solid #e2e8f0',
                padding: '0 18px',
                background: '#ffffff',
                gap: 12,
              }}
            >
              <button
                type="button"
                onClick={() => setActiveTab('url')}
                style={{
                  padding: '10px 4px',
                  fontSize: '0.82rem',
                  fontWeight: 700,
                  color: activeTab === 'url' ? '#0d9488' : '#64748b',
                  borderBottom: activeTab === 'url' ? '2px solid #0d9488' : '2px solid transparent',
                  background: 'none',
                  borderTop: 'none',
                  borderLeft: 'none',
                  borderRight: 'none',
                  cursor: 'pointer',
                  display: 'flex',
                  alignItems: 'center',
                  gap: 6,
                }}
              >
                <Link2 size={15} /> Direct Web URL
              </button>
              <button
                type="button"
                onClick={() => setActiveTab('upload')}
                style={{
                  padding: '10px 4px',
                  fontSize: '0.82rem',
                  fontWeight: 700,
                  color: activeTab === 'upload' ? '#0d9488' : '#64748b',
                  borderBottom: activeTab === 'upload' ? '2px solid #0d9488' : '2px solid transparent',
                  background: 'none',
                  borderTop: 'none',
                  borderLeft: 'none',
                  borderRight: 'none',
                  cursor: 'pointer',
                  display: 'flex',
                  alignItems: 'center',
                  gap: 6,
                }}
              >
                <Upload size={15} /> Upload from Device
              </button>
              <button
                type="button"
                onClick={() => setActiveTab('library')}
                style={{
                  padding: '10px 4px',
                  fontSize: '0.82rem',
                  fontWeight: 700,
                  color: activeTab === 'library' ? '#0d9488' : '#64748b',
                  borderBottom: activeTab === 'library' ? '2px solid #0d9488' : '2px solid transparent',
                  background: 'none',
                  borderTop: 'none',
                  borderLeft: 'none',
                  borderRight: 'none',
                  cursor: 'pointer',
                  display: 'flex',
                  alignItems: 'center',
                  gap: 6,
                }}
              >
                <BookOpen size={15} /> Emergix Library (400+)
              </button>
            </div>

            {/* Modal Body */}
            <div style={{ padding: '16px 18px', overflowY: 'auto', flex: 1 }}>
              {/* ─── TAB 1: URL ─── */}
              {activeTab === 'url' && (
                <div>
                  <div style={{ marginBottom: 14 }}>
                    <label style={{ display: 'block', fontSize: '0.78rem', fontWeight: 700, color: '#334155', marginBottom: 5 }}>
                      Direct Image URL:
                    </label>
                    <input
                      type="url"
                      value={inputUrl}
                      onChange={(e) => setInputUrl(e.target.value)}
                      placeholder="e.g. https://i.postimg.cc/xxx/ecg.jpg or /lessons/images/..."
                      style={{
                        width: '100%',
                        padding: '8px 10px',
                        fontSize: '0.82rem',
                        border: '1px solid #cbd5e1',
                        borderRadius: 6,
                        boxSizing: 'border-box',
                      }}
                    />
                  </div>

                  <div style={{ marginBottom: 14 }}>
                    <label style={{ display: 'block', fontSize: '0.78rem', fontWeight: 700, color: '#334155', marginBottom: 5 }}>
                      Caption / Alt Text:
                    </label>
                    <input
                      type="text"
                      value={inputCaption}
                      onChange={(e) => setInputCaption(e.target.value)}
                      placeholder="e.g. Figure 1: 12-lead ECG demonstrating acute anterolateral STEMI"
                      style={{
                        width: '100%',
                        padding: '8px 10px',
                        fontSize: '0.82rem',
                        border: '1px solid #cbd5e1',
                        borderRadius: 6,
                        boxSizing: 'border-box',
                      }}
                    />
                  </div>

                  {/* Live Preview Box */}
                  <div
                    style={{
                      border: '1px dashed #cbd5e1',
                      borderRadius: 8,
                      padding: 12,
                      minHeight: 110,
                      background: '#f8fafc',
                      display: 'flex',
                      flexDirection: 'column',
                      alignItems: 'center',
                      justifyContent: 'center',
                      gap: 8,
                    }}
                  >
                    {urlStatus === 'loading' && (
                      <div style={{ display: 'flex', alignItems: 'center', gap: 6, color: '#64748b', fontSize: '0.78rem' }}>
                        <Loader2 size={16} className="animate-spin" /> Testing image URL...
                      </div>
                    )}
                    {urlStatus === 'valid' && (
                      <div style={{ textAlign: 'center', width: '100%' }}>
                        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 4, color: '#059669', fontSize: '0.74rem', fontWeight: 700, marginBottom: 8 }}>
                          <Check size={14} /> Image verified and ready to insert
                        </div>
                        <img
                          src={inputUrl}
                          alt="Preview"
                          style={{ maxHeight: 160, maxWidth: '100%', borderRadius: 6, objectFit: 'contain', margin: '0 auto' }}
                        />
                      </div>
                    )}
                    {urlStatus === 'invalid' && (
                      <div style={{ display: 'flex', alignItems: 'center', gap: 6, color: '#dc2626', fontSize: '0.78rem' }}>
                        <AlertCircle size={16} /> Unable to load image from this URL. Please verify the link.
                      </div>
                    )}
                    {urlStatus === 'idle' && (
                      <span style={{ fontSize: '0.76rem', color: '#94a3b8' }}>
                        Enter an image URL above to see a live preview
                      </span>
                    )}
                  </div>
                </div>
              )}

              {/* ─── TAB 2: UPLOAD FROM DEVICE ─── */}
              {activeTab === 'upload' && (
                <div>
                  <div
                    onClick={() => fileInputRef.current?.click()}
                    style={{
                      border: '2px dashed #99f6e4',
                      borderRadius: 8,
                      padding: '24px 16px',
                      textAlign: 'center',
                      background: '#f0fdfa',
                      cursor: 'pointer',
                      marginBottom: 14,
                    }}
                  >
                    <input
                      ref={fileInputRef}
                      type="file"
                      accept="image/png,image/jpeg,image/webp,image/gif"
                      onChange={handleFileChange}
                      style={{ display: 'none' }}
                    />
                    <Upload size={28} style={{ color: '#0d9488', margin: '0 auto 8px' }} />
                    <strong style={{ display: 'block', fontSize: '0.85rem', color: '#134e4a', marginBottom: 4 }}>
                      {selectedFile ? selectedFile.name : 'Click or tap to choose an image from your device'}
                    </strong>
                    <span style={{ fontSize: '0.72rem', color: '#0f766e' }}>
                      Supports JPEG, PNG, WebP up to 10 MB. Saved permanently to Emergix Neon DB.
                    </span>
                  </div>

                  {filePreview && (
                    <div style={{ textAlign: 'center', marginBottom: 14 }}>
                      <img
                        src={filePreview}
                        alt="Preview"
                        style={{ maxHeight: 150, maxWidth: '100%', borderRadius: 6, objectFit: 'contain', border: '1px solid #e2e8f0' }}
                      />
                    </div>
                  )}

                  <div style={{ marginBottom: 10 }}>
                    <label style={{ display: 'block', fontSize: '0.78rem', fontWeight: 700, color: '#334155', marginBottom: 5 }}>
                      Figure Caption / Title:
                    </label>
                    <input
                      type="text"
                      value={inputCaption}
                      onChange={(e) => setInputCaption(e.target.value)}
                      placeholder="e.g. Figure 1: Chest radiograph demonstrating right pneumothorax"
                      style={{
                        width: '100%',
                        padding: '8px 10px',
                        fontSize: '0.82rem',
                        border: '1px solid #cbd5e1',
                        borderRadius: 6,
                        boxSizing: 'border-box',
                      }}
                    />
                  </div>

                  {uploadError && (
                    <div style={{ color: '#dc2626', fontSize: '0.76rem', marginTop: 6, display: 'flex', alignItems: 'center', gap: 4 }}>
                      <AlertCircle size={14} /> {uploadError}
                    </div>
                  )}
                </div>
              )}

              {/* ─── TAB 3: ACADEMY LIBRARY ─── */}
              {activeTab === 'library' && (
                <div>
                  <div style={{ display: 'flex', gap: 8, marginBottom: 10, flexWrap: 'wrap' }}>
                    <input
                      type="text"
                      value={librarySearch}
                      onChange={(e) => setLibrarySearch(e.target.value)}
                      placeholder="Search figures (e.g. ECG, fracture, chest, spine)..."
                      style={{
                        flex: 1,
                        minWidth: 180,
                        padding: '6px 10px',
                        fontSize: '0.78rem',
                        border: '1px solid #cbd5e1',
                        borderRadius: 6,
                      }}
                    />
                    <select
                      value={selectedCategory}
                      onChange={(e) => setSelectedCategory(e.target.value)}
                      style={{
                        padding: '6px 8px',
                        fontSize: '0.78rem',
                        border: '1px solid #cbd5e1',
                        borderRadius: 6,
                        background: '#ffffff',
                      }}
                    >
                      {categories.map((c) => (
                        <option key={c} value={c}>
                          {c === 'all' ? 'All Specialties' : c.charAt(0).toUpperCase() + c.slice(1)}
                        </option>
                      ))}
                    </select>
                  </div>

                  {libraryLoading ? (
                    <div style={{ textAlign: 'center', padding: 30, color: '#64748b', fontSize: '0.8rem' }}>
                      <Loader2 size={20} className="animate-spin" style={{ margin: '0 auto 8px' }} />
                      Loading academy figure catalog...
                    </div>
                  ) : filteredLibrary.length === 0 ? (
                    <div style={{ textAlign: 'center', padding: 30, color: '#94a3b8', fontSize: '0.78rem' }}>
                      No matching figures found in this category.
                    </div>
                  ) : (
                    <div
                      style={{
                        display: 'grid',
                        gridTemplateColumns: 'repeat(auto-fill, minmax(130px, 1fr))',
                        gap: 8,
                        maxHeight: 220,
                        overflowY: 'auto',
                        padding: '4px 2px',
                      }}
                    >
                      {filteredLibrary.slice(0, 100).map((item, idx) => {
                        const isSelected = selectedLibraryItem?.webPath === item.webPath;
                        return (
                          <div
                            key={idx}
                            onClick={() => {
                              setSelectedLibraryItem(item);
                              if (!inputCaption) setInputCaption(item.title);
                            }}
                            style={{
                              border: isSelected ? '2px solid #0d9488' : '1px solid #e2e8f0',
                              borderRadius: 6,
                              padding: 4,
                              background: isSelected ? '#f0fdfa' : '#ffffff',
                              cursor: 'pointer',
                              display: 'flex',
                              flexDirection: 'column',
                              alignItems: 'center',
                              transition: 'all 0.15s ease',
                            }}
                          >
                            <img
                              src={item.webPath}
                              alt={item.title}
                              loading="lazy"
                              style={{ width: '100%', height: 75, objectFit: 'cover', borderRadius: 4, marginBottom: 4 }}
                            />
                            <span
                              style={{
                                fontSize: '0.66rem',
                                color: isSelected ? '#0f766e' : '#334155',
                                fontWeight: isSelected ? 700 : 500,
                                textAlign: 'center',
                                whiteSpace: 'nowrap',
                                overflow: 'hidden',
                                textOverflow: 'ellipsis',
                                width: '100%',
                              }}
                              title={item.title}
                            >
                              {item.title}
                            </span>
                          </div>
                        );
                      })}
                    </div>
                  )}

                  {selectedLibraryItem && (
                    <div style={{ marginTop: 10, padding: 8, background: '#f8fafc', borderRadius: 6, border: '1px solid #e2e8f0' }}>
                      <span style={{ fontSize: '0.72rem', color: '#64748b' }}>Selected Figure:</span>
                      <strong style={{ display: 'block', fontSize: '0.8rem', color: '#0f766e' }}>
                        {selectedLibraryItem.title}
                      </strong>
                    </div>
                  )}
                </div>
              )}

              {/* ─── SMART PLACEMENT SELECTOR ─── */}
              <div
                style={{
                  marginTop: 14,
                  padding: '10px 12px',
                  background: '#f1f5f9',
                  borderRadius: 6,
                  border: '1px solid #e2e8f0',
                }}
              >
                <div style={{ display: 'flex', alignItems: 'center', gap: 5, marginBottom: 6 }}>
                  <Layers size={14} style={{ color: '#0d9488' }} />
                  <label style={{ fontSize: '0.76rem', fontWeight: 700, color: '#334155' }}>
                    Placement in Text (موضع ظهور الصورة في النص):
                  </label>
                </div>
                <div style={{ display: 'flex', flexWrap: 'wrap', gap: 8 }}>
                  <label
                    style={{
                      display: 'flex',
                      alignItems: 'center',
                      gap: 4,
                      fontSize: '0.74rem',
                      cursor: 'pointer',
                      background: selectedPlacement === 'auto' ? '#ccfbf1' : '#ffffff',
                      border: selectedPlacement === 'auto' ? '1px solid #0d9488' : '1px solid #cbd5e1',
                      padding: '4px 8px',
                      borderRadius: 4,
                      fontWeight: selectedPlacement === 'auto' ? 700 : 500,
                      color: selectedPlacement === 'auto' ? '#0f766e' : '#334155',
                    }}
                  >
                    <input
                      type="radio"
                      name="placement"
                      value="auto"
                      checked={selectedPlacement === 'auto'}
                      onChange={() => setSelectedPlacement('auto')}
                      style={{ display: 'none' }}
                    />
                    🩺 Before Question (بين السيناريو والسؤال)
                  </label>
                  <label
                    style={{
                      display: 'flex',
                      alignItems: 'center',
                      gap: 4,
                      fontSize: '0.74rem',
                      cursor: 'pointer',
                      background: selectedPlacement === 'bottom' ? '#ccfbf1' : '#ffffff',
                      border: selectedPlacement === 'bottom' ? '1px solid #0d9488' : '1px solid #cbd5e1',
                      padding: '4px 8px',
                      borderRadius: 4,
                      fontWeight: selectedPlacement === 'bottom' ? 700 : 500,
                      color: selectedPlacement === 'bottom' ? '#0f766e' : '#334155',
                    }}
                  >
                    <input
                      type="radio"
                      name="placement"
                      value="bottom"
                      checked={selectedPlacement === 'bottom'}
                      onChange={() => setSelectedPlacement('bottom')}
                      style={{ display: 'none' }}
                    />
                    ⬇️ End of Text (نهاية النص)
                  </label>
                  <label
                    style={{
                      display: 'flex',
                      alignItems: 'center',
                      gap: 4,
                      fontSize: '0.74rem',
                      cursor: 'pointer',
                      background: selectedPlacement === 'top' ? '#ccfbf1' : '#ffffff',
                      border: selectedPlacement === 'top' ? '1px solid #0d9488' : '1px solid #cbd5e1',
                      padding: '4px 8px',
                      borderRadius: 4,
                      fontWeight: selectedPlacement === 'top' ? 700 : 500,
                      color: selectedPlacement === 'top' ? '#0f766e' : '#334155',
                    }}
                  >
                    <input
                      type="radio"
                      name="placement"
                      value="top"
                      checked={selectedPlacement === 'top'}
                      onChange={() => setSelectedPlacement('top')}
                      style={{ display: 'none' }}
                    />
                    ⬆️ Top of Text (بداية النص)
                  </label>
                </div>
              </div>
            </div>

            {/* Modal Footer */}
            <div
              style={{
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'flex-end',
                gap: 8,
                padding: '12px 18px',
                borderTop: '1px solid #e2e8f0',
                background: '#f8fafc',
              }}
            >
              <button
                type="button"
                onClick={() => {
                  setIsAddModalOpen(false);
                  resetModal();
                }}
                disabled={uploadLoading}
                style={{
                  padding: '6px 14px',
                  fontSize: '0.8rem',
                  fontWeight: 600,
                  color: '#64748b',
                  background: 'none',
                  border: '1px solid #cbd5e1',
                  borderRadius: 6,
                  cursor: 'pointer',
                }}
              >
                Cancel
              </button>

              {activeTab === 'url' && (
                <button
                  type="button"
                  onClick={handleInsertUrl}
                  disabled={!inputUrl.trim()}
                  style={{
                    padding: '6px 16px',
                    fontSize: '0.8rem',
                    fontWeight: 700,
                    color: '#ffffff',
                    background: inputUrl.trim() ? '#0d9488' : '#94a3b8',
                    border: 'none',
                    borderRadius: 6,
                    cursor: inputUrl.trim() ? 'pointer' : 'not-allowed',
                  }}
                >
                  Insert Figure
                </button>
              )}

              {activeTab === 'upload' && (
                <button
                  type="button"
                  onClick={handleUploadAndInsert}
                  disabled={!selectedFile || uploadLoading}
                  style={{
                    padding: '6px 16px',
                    fontSize: '0.8rem',
                    fontWeight: 700,
                    color: '#ffffff',
                    background: selectedFile && !uploadLoading ? '#0d9488' : '#94a3b8',
                    border: 'none',
                    borderRadius: 6,
                    cursor: selectedFile && !uploadLoading ? 'pointer' : 'not-allowed',
                    display: 'flex',
                    alignItems: 'center',
                    gap: 6,
                  }}
                >
                  {uploadLoading && <Loader2 size={14} className="animate-spin" />}
                  {uploadLoading ? 'Saving...' : 'Upload & Insert'}
                </button>
              )}

              {activeTab === 'library' && (
                <button
                  type="button"
                  onClick={handleInsertFromLibrary}
                  disabled={!selectedLibraryItem}
                  style={{
                    padding: '6px 16px',
                    fontSize: '0.8rem',
                    fontWeight: 700,
                    color: '#ffffff',
                    background: selectedLibraryItem ? '#0d9488' : '#94a3b8',
                    border: 'none',
                    borderRadius: 6,
                    cursor: selectedLibraryItem ? 'pointer' : 'not-allowed',
                  }}
                >
                  Insert Selected Figure
                </button>
              )}
            </div>
          </div>
        </div>
      )}

      {/* ─── LIGHTBOX ZOOM MODAL ─── */}
      {zoomImage && (
        <div
          style={{
            position: 'fixed',
            inset: 0,
            background: 'rgba(0, 0, 0, 0.85)',
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'center',
            justifyContent: 'center',
            zIndex: 100000,
            padding: 20,
          }}
          onClick={() => setZoomImage(null)}
        >
          <div
            style={{
              position: 'relative',
              maxWidth: '92vw',
              maxHeight: '88vh',
              display: 'flex',
              flexDirection: 'column',
              alignItems: 'center',
            }}
            onClick={(e) => e.stopPropagation()}
          >
            <button
              type="button"
              onClick={() => setZoomImage(null)}
              style={{
                position: 'absolute',
                top: -36,
                right: 0,
                background: 'rgba(255, 255, 255, 0.2)',
                border: 'none',
                color: '#ffffff',
                padding: '4px 10px',
                borderRadius: 4,
                cursor: 'pointer',
                fontSize: '0.8rem',
                display: 'flex',
                alignItems: 'center',
                gap: 4,
              }}
            >
              <X size={16} /> Close
            </button>
            <img
              src={zoomImage.src}
              alt={zoomImage.alt}
              style={{
                maxWidth: '100%',
                maxHeight: '80vh',
                borderRadius: 8,
                boxShadow: '0 25px 50px -12px rgba(0, 0, 0, 0.5)',
                objectFit: 'contain',
              }}
            />
            {zoomImage.caption && (
              <p
                style={{
                  margin: '12px 0 0',
                  color: '#ffffff',
                  fontSize: '0.88rem',
                  fontWeight: 650,
                  textAlign: 'center',
                  background: 'rgba(0,0,0,0.6)',
                  padding: '6px 14px',
                  borderRadius: 6,
                }}
              >
                {zoomImage.caption}
              </p>
            )}
          </div>
        </div>
      )}
    </div>
  );
};
