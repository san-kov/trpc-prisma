/*
  Warnings:

  - You are about to drop the column `bookListId` on the `Profile` table. All the data in the column will be lost.

*/
-- CreateTable
CREATE TABLE "_BookListToProfile" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_BookListToProfile_A_fkey" FOREIGN KEY ("A") REFERENCES "BookList" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_BookListToProfile_B_fkey" FOREIGN KEY ("B") REFERENCES "Profile" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Profile" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "username" TEXT NOT NULL
);
INSERT INTO "new_Profile" ("id", "username") SELECT "id", "username" FROM "Profile";
DROP TABLE "Profile";
ALTER TABLE "new_Profile" RENAME TO "Profile";
CREATE UNIQUE INDEX "Profile_username_key" ON "Profile"("username");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "_BookListToProfile_AB_unique" ON "_BookListToProfile"("A", "B");

-- CreateIndex
CREATE INDEX "_BookListToProfile_B_index" ON "_BookListToProfile"("B");
