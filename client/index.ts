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
const { addBookToLibrary } = testApi;


(async () => {

    const myProfileId = 'e8a4099e-38db-4c0c-9d25-878617f44a38'
    const bookId = '80690e26-da2f-4888-8fd9-e0ca3c70a230'
    // const library = await getMyLibrary(myProfileId)
    await addBookToLibrary(myProfileId, bookId)

    // console.log(library.books)

})()

export type TRPCType = typeof trpc