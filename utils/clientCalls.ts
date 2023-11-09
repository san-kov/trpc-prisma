import { TRPCType } from "../client"

export function createTestApi(trpc: TRPCType) {
    return ({
        async getBooksList() {
            return trpc.books.booksList.query()
        },

        async addBookToLibrary(profileId: string, bookId: string) {
            return trpc.library.addToLibrary.mutate({
                profileId,
                bookId
            })
        },

        async getMyLibrary(profileId: string) {
            return trpc.library.getMyLibrary.query(profileId)
        },

        async addReadingSession({
            pagesCount,
            profileId,
            bookId
        }: { pagesCount: number, profileId: string, bookId: string }) {
            return trpc.library.addReadingSession.mutate({
                pagesCount,
                profileId,
                bookId
            })
        }
    })
}
