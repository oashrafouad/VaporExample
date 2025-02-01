import Fluent

struct CreateJoke: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("jokes")
            .id()
            .field("content", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("jokes").delete()
    }
}