/*
  Warnings:

  - A unique constraint covering the columns `[profileId,bookId]` on the table `PersonalBook` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "PersonalBook_profileId_bookId_key" ON "PersonalBook"("profileId", "bookId");
