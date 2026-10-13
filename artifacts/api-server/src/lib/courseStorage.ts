import { Storage } from "@google-cloud/storage";

const SIDECAR = "http://127.0.0.1:1106";
const storage = new Storage({
  credentials: {
    audience: "replit",
    subject_token_type: "access_token",
    token_url: `${SIDECAR}/token`,
    type: "external_account",
    credential_source: {
      url: `${SIDECAR}/credential`,
      format: { type: "json", subject_token_field_name: "access_token" },
    },
    universe_domain: "googleapis.com",
  },
  projectId: "",
});

function getFile(storageKey: string) {
  if (!storageKey.startsWith("/objects/course-assets/")) {
    throw new Error("Invalid course asset path.");
  }
  const privateDir = process.env.PRIVATE_OBJECT_DIR;
  if (!privateDir) throw new Error("Private object storage is not configured.");

  const relativePath = storageKey.slice("/objects/".length);
  const fullPath = `${privateDir.replace(/\/+$/, "")}/${relativePath}`;
  const parts = fullPath.split("/").filter(Boolean);
  const bucketName = parts[0];
  const objectName = parts.slice(1).join("/");
  if (!bucketName || !objectName) throw new Error("Invalid private object path.");
  return storage.bucket(bucketName).file(objectName);
}

async function signCourseAssetUrl(storageKey: string, method: "GET" | "PUT", ttlSeconds: number) {
  const file = getFile(storageKey);
  const expiresAt = new Date(Date.now() + ttlSeconds * 1000);
  const response = await fetch(`${SIDECAR}/object-storage/signed-object-url`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      bucket_name: file.bucket.name,
      object_name: file.name,
      method,
      expires_at: expiresAt.toISOString(),
    }),
    signal: AbortSignal.timeout(30_000),
  });
  if (!response.ok) {
    throw new Error(`Unable to prepare the private upload (status ${response.status}).`);
  }
  const result: unknown = await response.json();
  if (!result || typeof result !== "object" || !("signed_url" in result) || typeof result.signed_url !== "string") {
    throw new Error("The private object storage service returned an invalid response.");
  }
  return { url: result.signed_url, expiresAt };
}

export async function signCourseAssetUpload(storageKey: string, ttlSeconds: number) {
  const signed = await signCourseAssetUrl(storageKey, "PUT", ttlSeconds);
  return { uploadUrl: signed.url, expiresAt: signed.expiresAt };
}

export async function signCourseAssetRead(storageKey: string, ttlSeconds: number) {
  const signed = await signCourseAssetUrl(storageKey, "GET", ttlSeconds);
  return signed.url;
}

export async function getCourseAssetMetadata(storageKey: string) {
  const file = getFile(storageKey);
  const [exists] = await file.exists();
  if (!exists) return null;
  const [metadata] = await file.getMetadata();
  return {
    sizeBytes: Number(metadata.size ?? 0),
    mimeType: typeof metadata.contentType === "string" ? metadata.contentType : null,
  };
}
