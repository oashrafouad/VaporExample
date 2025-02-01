import Fluent
import Vapor

final class Joke: Model, Content {
    static let schema = "jokes"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "content")
    var content: String

    init() {}

    init(id: UUID? = nil, content: String) {
        self.id = id
        self.content = content
    }
}