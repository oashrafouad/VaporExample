import Fluent
import FluentPostgresDriver
import Vapor

public func configure(_ app: Application) async throws {
    // Configure PostgreSQL database
    if let databaseURL = Environment.get("DATABASE_URL") {
        try app.databases.use(.postgres(url: databaseURL), as: .psql)
    } else {
        app.databases.use(.postgres(
            configuration: PostgresConfiguration(
                hostname: Environment.get("DATABASE_HOST")!,
                port: 5432,
                username: Environment.get("DATABASE_USERNAME")!,
                password: Environment.get("DATABASE_PASSWORD")!,
                database: Environment.get("DATABASE_NAME")!
            )
        ), as: .psql)
    }

    // Run migrations
    app.migrations.add(CreateJoke())

    try await app.autoMigrate().get()

    // Register routes
    try routes(app)
}
