import { logger } from "./logger";

/**
 * Auto-migrations and seeds are permanently disabled.
 * The database schema and content are managed purely from backup_1.sql.
 */
export async function runAutoMigrationsAndSeeds(): Promise<void> {
  logger.info("Automatic migrations & seeds are completely disabled. Database is managed purely from backup_1.sql.");
}
