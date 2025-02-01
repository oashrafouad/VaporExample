import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works! #2"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    app.get("example") { req async -> String in

        "This is an example"
    }
    // app.get("hello", ":name") { req async -> String in
    //     guard let name = req.parameters.get("name") else {
    //         throw Abort(.badRequest)
    //     }
    //     return "Hello, \(name)!"
    // }
}
