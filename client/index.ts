import { createTRPCProxyClient, httpBatchLink } from '@trpc/client';
import { constrainedMemory } from 'process';
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

(async () => {
    const res = await trpc.booksList.query()

    const bookId = res[0]?.id

    console.log(bookId)
})()