/*
  Warnings:

  - You are about to drop the column `profileId` on the `Book` table. All the data in the column will be lost.

*/
-- CreateTable
CREATE TABLE "BooksOnProfiles" (
    "bookId" TEXT NOT NULL,
    "profileId" TEXT NOT NULL,

    PRIMARY KEY ("bookId", "profileId"),
    CONSTRAINT "BooksOnProfiles_bookId_fkey" FOREIGN KEY ("bookId") REFERENCES "Book" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "BooksOnProfiles_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Book" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "releaseYear" INTEGER NOT NULL,
    "authorId" TEXT NOT NULL,
    "adRelease" BOOLEAN NOT NULL DEFAULT true,
    "paperPages" INTEGER NOT NULL,
    "pages" INTEGER NOT NULL,
    CONSTRAINT "Book_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "Author" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Book" ("adRelease", "authorId", "description", "id", "pages", "paperPages", "releaseYear", "title") SELECT "adRelease", "authorId", "description", "id", "pages", "paperPages", "releaseYear", "title" FROM "Book";
DROP TABLE "Book";
ALTER TABLE "new_Book" RENAME TO "Book";
CREATE UNIQUE INDEX "Book_title_key" ON "Book"("title");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
