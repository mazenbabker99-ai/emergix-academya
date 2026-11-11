import { Router, type IRouter } from "express";
import { pool } from "@workspace/db";
import { sendError } from "../lib/errors";

const router: IRouter = Router();

// Allowed image mime types for medical figures
const ALLOWED_MIME_TYPES = new Set([
  "image/jpeg",
  "image/png",
  "image/webp",
  "image/gif",
  "image/svg+xml",
]);

// Maximum file size: 10 MB
const MAX_IMAGE_SIZE = 10 * 1024 * 1024;

/**
 * Upload an image (base64 encoded) and store in PostgreSQL
 * POST /admin/images/upload
 */
router.post("/images/upload", async (req, res) => {
  try {
    const { filename, mimeType, base64Data, caption } = req.body || {};

    if (!filename || typeof filename !== "string") {
      return void sendError(res, 400, "invalid_filename", "A valid image filename is required.");
    }

    const cleanMime = (mimeType || "").trim().toLowerCase();
    if (!ALLOWED_MIME_TYPES.has(cleanMime)) {
      return void sendError(
        res,
        400,
        "unsupported_mime_type",
        "Supported formats: JPEG, PNG, WebP, GIF, SVG.",
      );
    }

    if (!base64Data || typeof base64Data !== "string") {
      return void sendError(res, 400, "missing_data", "Image data is required.");
    }

    // Clean data URL prefix if present (e.g. data:image/png;base64,...)
    const cleanBase64 = base64Data.replace(/^data:image\/[a-z0-9+-]+;base64,/i, "");
    const buffer = Buffer.from(cleanBase64, "base64");

    if (buffer.length === 0) {
      return void sendError(res, 400, "empty_file", "The uploaded file is empty.");
    }

    if (buffer.length > MAX_IMAGE_SIZE) {
      return void sendError(res, 413, "file_too_large", "The image file exceeds the 10 MB limit.");
    }

    const cleanFilename = filename
      .replace(/[^\p{L}\p{N}._-]+/gu, "-")
      .slice(0, 150);

    const uploadedBy = req.auth?.user?.id || null;

    const result = await pool.query(
      `INSERT INTO lesson_images (filename, mime_type, size_bytes, data, caption, uploaded_by)
       VALUES ($1, $2, $3, $4, $5, $6)
       RETURNING id, filename, mime_type, size_bytes, caption, created_at`,
      [cleanFilename, cleanMime, buffer.length, buffer, caption || null, uploadedBy],
    );

    const row = result.rows[0];
    return res.status(201).json({
      success: true,
      image: {
        id: row.id,
        url: `/api/images/${row.id}`,
        filename: row.filename,
        mimeType: row.mime_type,
        sizeBytes: row.size_bytes,
        caption: row.caption,
        createdAt: row.created_at,
      },
    });
  } catch (error) {
    req.log.error({ err: error }, "Failed to upload lesson image");
    return void sendError(res, 500, "upload_failed", "Failed to save the image. Please try again.");
  }
});

/**
 * List recently uploaded images for the image picker
 * GET /admin/images/recent
 */
router.get("/images/recent", async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT id, filename, mime_type, size_bytes, caption, created_at
       FROM lesson_images
       ORDER BY created_at DESC
       LIMIT 50`,
    );

    const images = result.rows.map((row) => ({
      id: row.id,
      url: `/api/images/${row.id}`,
      filename: row.filename,
      mimeType: row.mime_type,
      sizeBytes: row.size_bytes,
      caption: row.caption,
      createdAt: row.created_at,
    }));

    return res.json({ success: true, images });
  } catch (error) {
    req.log.error({ err: error }, "Failed to fetch recent images");
    return void sendError(res, 500, "fetch_failed", "Failed to retrieve images.");
  }
});

/**
 * Delete an uploaded image
 * DELETE /admin/images/:id
 */
router.delete("/images/:id", async (req, res) => {
  try {
    const { id } = req.params;
    await pool.query("DELETE FROM lesson_images WHERE id = $1", [id]);
    return res.json({ success: true, message: "Image deleted successfully." });
  } catch (error) {
    req.log.error({ err: error }, "Failed to delete image");
    return void sendError(res, 500, "delete_failed", "Failed to delete image.");
  }
});

export default router;
