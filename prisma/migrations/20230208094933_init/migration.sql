/*
  Warnings:

  - Made the column `activeCode` on table `users` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE `users` ADD COLUMN `activationDate` DATETIME(3) NULL,
    MODIFY `activeCode` VARCHAR(191) NOT NULL;
