import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient()

async function main() {
    const profile = await prisma.profile.create({
        data: {
            username: "qwe2qweqwe22"
        }
    })
    const newAuthor = await prisma.author.create({
        data: {
            fullName: "Samuel Beckett",
            years: "1890-1950",
            authorImage: "",

        }
    })

    const newBook = await prisma.book.create({
        data: {
            title: "Moll2oy1232",
            author: {
                connect: newAuthor
            },
            pages: 1200,
            paperPages: 200,
            releaseYear: 1980,
        }
    })

    console.log(newAuthor, newBook, profile)

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