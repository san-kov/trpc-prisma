import { createTRPCProxyClient, httpBatchLink } from '@trpc/client';
import type { AppRouter } from '../'
//     👆 **type-only** import

// Pass AppRouter as generic here. 👇 This lets the `trpc` object know
// what procedures are available on the server and their input/output types.
const trpc = createTRPCProxyClient<AppRouter>({
    links: [
        httpBatchLink({
            url: 'http://localhost:8080',
        }),
    ],
});

async function getBooksList() {
    return trpc.booksList.query()
}

async function addBookToLibrary(profileId: string, bookId: string) {
    return trpc.addToLibrary.query({
        profileId,
        bookId
    })
}

async function getMyLibrary(profileId: string) {
    return trpc.getMyLibrary.query(profileId)
}

(async () => {

    const myProfileId = 'e4cc1a59-4843-4c13-be33-ffa88d5207b3'
    const library = await getMyLibrary(myProfileId)

    console.log(library.books)

})()