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

            await prisma.booksOnProfiles.create({
                data: {
                    bookId,
                    profileId
                }
            })

            return book
        }),
    getMyProfile: publicProcedure
        .query(async () => {
            const profile = await prisma.profile.findFirst()

            return profile
        }),
    getMyLibrary: publicProcedure.input(z.string()).query(async ({ input }) => {
        const id = input
        const profile = await prisma.profile.findUnique({
            where: {
                id
            },
            include: {
                books: {
                    select: {
                        book: true
                    }
                }
            }
        })

        if (!profile) {
            throw new TRPCError({
                code: "NOT_FOUND",
                message: `User not found`
            })
        }

        return profile
    })

});


const server = createHTTPServer({
    router: appRouter
})

server.listen(8080)

export type AppRouter = typeof appRouter;