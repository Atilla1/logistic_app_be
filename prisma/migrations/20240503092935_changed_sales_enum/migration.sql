/*
  Warnings:

  - The values [IN_TRANSIT] on the enum `SaleStatus` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "SaleStatus_new" AS ENUM ('PENDING', 'SENT', 'RECEIVED');
ALTER TABLE "Sale" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "Sale" ALTER COLUMN "status" TYPE "SaleStatus_new" USING ("status"::text::"SaleStatus_new");
ALTER TYPE "SaleStatus" RENAME TO "SaleStatus_old";
ALTER TYPE "SaleStatus_new" RENAME TO "SaleStatus";
DROP TYPE "SaleStatus_old";
ALTER TABLE "Sale" ALTER COLUMN "status" SET DEFAULT 'PENDING';
COMMIT;
