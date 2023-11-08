import { createTRPCProxyClient, httpBatchLink } from '@trpc/client';
import type { AppRouter } from '../'
import { createTestApi } from '../utils/clientCalls';

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

const testApi = createTestApi(trpc);
const { addBookToLibrary, addReadingSession } = testApi;


(async () => {

    const profileId = 'a0dc14a5-a49d-4318-b889-ad9f5804eb53'
    const bookId = 'd5075e89-f454-4be7-a737-f96ea8f9041b'
    // const library = await getMyLibrary(myProfileId)
    // await addBookToLibrary(myProfileId, bookId)

    // console.log(library.books)

    const session = await addReadingSession({
        bookId,
        profileId,
        pagesCount: 100
    })

    console.log(session)

})()

export type TRPCType = typeof trpc