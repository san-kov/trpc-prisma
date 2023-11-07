import { publicProcedure, router } from './trpc';
import { createHTTPServer } from "@trpc/server/adapters/standalone"
import { PrismaClient } from '@prisma/client'
import { z } from 'zod'
import { TRPCError } from '@trpc/server';

const prisma = new PrismaClient();

const appRouter = router({
    booksList: publicProcedure
        .query(async () => {
            const books = await prisma.book.findMany()

            return books
        }),
    addToLibrary: publicProcedure
        .input(z.object({
            profileId: z.string(),
            bookId: z.string()
        }))
        .query(async ({ input }) => {
            const { profileId, bookId } = input

            const book = await prisma.book.findUnique({
                where: {
                    id: bookId
                }
            })

            if (!book) {
                throw new TRPCError({
                    code: "NOT_FOUND",
                    message: `No book with id${bookId}`
                })
            }

            await prisma.profile.update({
                where: {
                    id: profileId
                },
                data: {
                    bookLibrary: {
                        connect: {
                            id: bookId
                        }
                    }
                }
            })

        }),
    userCreate: publicProcedure
        .input(z.object({ name: z.string() }))
        .mutation(async (opts) => {
            return {}
        })
});


const server = createHTTPServer({
    router: appRouter
})

server.listen(8080)

export type AppRouter = typeof appRouter;