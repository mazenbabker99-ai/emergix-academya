import app from "./app";
import { startAccountDeletionJob } from "./lib/accountDeletion";
import { runAutoMigrationsAndSeeds } from "./lib/autoMigration";
import { logger } from "./lib/logger";

const rawPort = process.env["PORT"] || "8080";
const port = Number(rawPort);

if (Number.isNaN(port) || port <= 0) {
  throw new Error(`Invalid PORT value: "${rawPort}"`);
}

app.listen(port, async (err) => {
  if (err) {
    logger.error({ err }, "Error listening on port");
    process.exit(1);
  }

  logger.info({ port }, "Server listening");
  startAccountDeletionJob();

  // Run migrations & seeds automatically so that any DB (Dev or Production Replit Deployment) is always up to date
  await runAutoMigrationsAndSeeds();
});

