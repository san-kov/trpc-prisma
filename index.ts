import { router } from './trpc';
import { createHTTPServer } from "@trpc/server/adapters/standalone"
import { booksRouter } from './routers/books';
import { libraryRouter } from './routers/library';


const appRouter = router({
    books: booksRouter,
    library: libraryRouter
});


const server = createHTTPServer({
    router: appRouter
})

server.listen(8080)

export type AppRouter = typeof appRouter;