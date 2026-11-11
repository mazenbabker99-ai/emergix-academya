import { drizzle } from "drizzle-orm/node-postgres";
import pg from "pg";
import * as schema from "./schema";

const { Pool } = pg;

const connectionString =
  process.env.DATABASE_URL_POOLED ||
  process.env.NEON_DATABASE_URL ||
  process.env.DATABASE_URL;

if (!connectionString) {
  throw new Error(
    "DATABASE_URL must be set. Did you forget to provision a database?",
  );
}

try {
  const host = new URL(connectionString).host;
  console.log(`[db] Connecting to database host: ${host}`);
} catch {
  // invalid URL format, ignore
}

export const pool = new Pool({ connectionString });
export const db = drizzle(pool, { schema });

export * from "./schema";
