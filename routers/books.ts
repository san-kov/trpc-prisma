import { prisma } from "../prisma/prismaClient";
import { publicProcedure, router } from "../trpc";

export const booksRouter = router({
    booksList: publicProcedure
        .query(async () => {
            const books = await prisma.book.findMany()

            return books
        }),
})