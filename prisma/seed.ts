import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient()

async function main() {
    const newAuthor = await prisma.author.create({
        data: {
            fullName: "Samuel Beckett",
            years: "1890-1950",
            authorImage: "",

        }
    })

    const profilePromise = prisma.profile.create({
        data: {
            username: "sankov"
        }
    })

    const bookPromise = prisma.book.create({
        data: {
            title: "Molloy",
            author: {
                connect: newAuthor
            },
            pages: 1200,
            paperPages: 200,
            releaseYear: 1980,
        }
    })

    await Promise.all([profilePromise, bookPromise])

}

main()
    .then(async () => {
        await prisma.$disconnect()
    })
    .catch(async (e) => {
        console.error(e)
        await prisma.$disconnect()
        process.exit(1)
    })