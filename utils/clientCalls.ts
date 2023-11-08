import { TRPCType } from "../client"

export function createTestApi(trpc: TRPCType) {
    return ({
        async getBooksList() {
            return trpc.booksList.query()
        },

        async addBookToLibrary(profileId: string, bookId: string) {
            return trpc.addToLibrary.query({
                profileId,
                bookId
            })
        },

        async getMyLibrary(profileId: string) {
            return trpc.getMyLibrary.query(profileId)
        }
    })
}
