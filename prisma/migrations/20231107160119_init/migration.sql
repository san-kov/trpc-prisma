/*
  Warnings:

  - The primary key for the `Book` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Author` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `ReadingSession` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `PersonalBook` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `BookList` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Genre` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Profile` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
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
    "profileId" TEXT,
    CONSTRAINT "Book_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "Author" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Book_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Book" ("adRelease", "authorId", "description", "id", "pages", "paperPages", "profileId", "releaseYear", "title") SELECT "adRelease", "authorId", "description", "id", "pages", "paperPages", "profileId", "releaseYear", "title" FROM "Book";
DROP TABLE "Book";
ALTER TABLE "new_Book" RENAME TO "Book";
CREATE UNIQUE INDEX "Book_title_key" ON "Book"("title");
CREATE TABLE "new_Author" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "fullName" TEXT NOT NULL,
    "authorImage" TEXT NOT NULL,
    "years" TEXT NOT NULL,
    "bio" TEXT
);
INSERT INTO "new_Author" ("authorImage", "bio", "fullName", "id", "years") SELECT "authorImage", "bio", "fullName", "id", "years" FROM "Author";
DROP TABLE "Author";
ALTER TABLE "new_Author" RENAME TO "Author";
CREATE TABLE "new_ReadingSession" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "pagesCount" INTEGER NOT NULL,
    "bookId" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "profileId" TEXT,
    CONSTRAINT "ReadingSession_bookId_fkey" FOREIGN KEY ("bookId") REFERENCES "Book" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "ReadingSession_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_ReadingSession" ("bookId", "createdAt", "id", "pagesCount", "profileId") SELECT "bookId", "createdAt", "id", "pagesCount", "profileId" FROM "ReadingSession";
DROP TABLE "ReadingSession";
ALTER TABLE "new_ReadingSession" RENAME TO "ReadingSession";
CREATE TABLE "new_PersonalBook" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "bookId" TEXT NOT NULL,
    "profileId" TEXT,
    "completed" BOOLEAN NOT NULL DEFAULT false,
    "completedAt" DATETIME,
    "pagesDone" INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT "PersonalBook_bookId_fkey" FOREIGN KEY ("bookId") REFERENCES "Book" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "PersonalBook_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_PersonalBook" ("bookId", "completed", "completedAt", "id", "pagesDone", "profileId") SELECT "bookId", "completed", "completedAt", "id", "pagesDone", "profileId" FROM "PersonalBook";
DROP TABLE "PersonalBook";
ALTER TABLE "new_PersonalBook" RENAME TO "PersonalBook";
CREATE TABLE "new_BookList" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "bookId" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "cover" TEXT,
    CONSTRAINT "BookList_bookId_fkey" FOREIGN KEY ("bookId") REFERENCES "Book" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_BookList" ("bookId", "cover", "description", "id") SELECT "bookId", "cover", "description", "id" FROM "BookList";
DROP TABLE "BookList";
ALTER TABLE "new_BookList" RENAME TO "BookList";
CREATE TABLE "new_Genre" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "bookId" TEXT,
    CONSTRAINT "Genre_bookId_fkey" FOREIGN KEY ("bookId") REFERENCES "Book" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Genre" ("bookId", "description", "id", "title") SELECT "bookId", "description", "id", "title" FROM "Genre";
DROP TABLE "Genre";
ALTER TABLE "new_Genre" RENAME TO "Genre";
CREATE UNIQUE INDEX "Genre_title_key" ON "Genre"("title");
CREATE TABLE "new_Profile" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "username" TEXT NOT NULL,
    "bookListId" TEXT NOT NULL,
    CONSTRAINT "Profile_bookListId_fkey" FOREIGN KEY ("bookListId") REFERENCES "BookList" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Profile" ("bookListId", "id", "username") SELECT "bookListId", "id", "username" FROM "Profile";
DROP TABLE "Profile";
ALTER TABLE "new_Profile" RENAME TO "Profile";
CREATE UNIQUE INDEX "Profile_username_key" ON "Profile"("username");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
