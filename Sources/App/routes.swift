import Vapor
import Fluent

// Define a struct to represent the JSON response
struct JokeResponse: Content {
    let content: String
}

// Define a struct to represent the JSON request for adding a joke
struct AddJokeRequest: Content {
    let joke: String
}

func routes(_ app: Application) throws {
    app.get { req async in
        "Call /joke to get a random joke"
    }

    // Route to return a random joke
    app.get("joke") { req async throws -> JokeResponse in
        let jokes = try await Joke.query(on: req.db).all()
        guard let randomJoke = jokes.randomElement() else {
            return JokeResponse(content: "No jokes available.")
        }
        return JokeResponse(content: randomJoke.content)
    }

    // Route to add a new joke
    app.post("add-joke") { req async throws -> HTTPStatus in
        let addJokeRequest = try req.content.decode(AddJokeRequest.self)
        
        // Basic authentication
        guard let authHeader = req.headers.basicAuthorization,
              authHeader.username == "amourakora2001@gmail.com",
              authHeader.password == "BuDj8gYhQBLzc" else {
            throw Abort(.unauthorized)
        }

        let joke = Joke(content: addJokeRequest.joke)
        try await joke.save(on: req.db)
        return .ok
    }
}
