
import FluentProvider

final class Client: Model {
    let storage = Storage()
    
    let client_name: String
    
    struct Properties {
        static let id = "id"
        static let client_name = "client_name"
    }
    
    init(client_name: String) {
        self.client_name = client_name
    }
    
    init(row: Row) throws {
        client_name = try row.get(Properties.client_name)
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Properties.client_name, client_name)
        return row
    }
}

extension Client: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) { builder in
            builder.id()
            builder.string(Properties.client_name)
        }
    }
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

extension Client: JSONRepresentable{
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Properties.id, id)
        try json.set(Properties.client_name, client_name)
        return json
    }
}

extension Client {
    var contract: Children<Client, Contract> {
        return children()
    }
}



extension Client: ResponseRepresentable {}
