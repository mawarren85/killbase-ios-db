
import FluentProvider

final class Codename: Model {
    let storage = Storage()
    
    let code_name: String
    let assassinId: Identifier?
    
    struct Properties {
        static let id = "id"
        static let code_name = "code_name"
        static let assassinID = "assassin_id"
    }
    
    init(code_name: String, assassin: Assassin ) {
        self.code_name = code_name
        self.assassinId = assassin.id
    }
    
    init(row: Row) throws {
        code_name = try row.get(Properties.code_name)
        assassinId = try row.get(Assassin.foreignIdKey)
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Properties.code_name, code_name)
        try row.set(Assassin.foreignIdKey, assassinId)
        return row
    }
}

extension Codename: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) { builder in
            builder.id()
            builder.string(Properties.code_name)
            builder.parent(Assassin.self)
        }
    }
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

extension Codename: JSONRepresentable{
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Properties.id, id)
        try json.set(Properties.code_name, code_name)
        try json.set(Properties.assassinID, assassinId)
        return json
    }
}

extension Codename {
    var assassin: Parent<Codename, Assassin> {
        return parent(id: assassinId)
    }
}

extension Codename: ResponseRepresentable {}
