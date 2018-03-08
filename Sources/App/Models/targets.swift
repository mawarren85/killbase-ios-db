import FluentProvider

final class Target: Model {
    let storage = Storage()
    
    let target_name: String
    let target_location: String
    let target_photo: String
    let target_security: Int
    
    struct Properties {
        static let id = "id"
        static let target_name = "target_name"
        static let target_location = "target_location"
        static let target_photo = "target_photo"
        static let target_security = "target_security"
    }
    
    init(target_name: String, target_location: String, target_photo: String, target_security: Int) {
        self.target_name = target_name
        self.target_location = target_location
        self.target_photo = target_photo
        self.target_security = target_security
    }
    
    init(row: Row) throws {
        target_name = try row.get(Properties.target_name)
        target_location = try row.get(Properties.target_location)
        target_photo = try row.get(Properties.target_photo)
        target_security = try row.get(Properties.target_security)
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Properties.target_name, target_name)
        try row.set(Properties.target_location, target_location)
        try row.set(Properties.target_photo, target_photo)
        try row.set(Properties.target_security, target_security)
        return row
    }
}

extension Target: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) { builder in
            builder.id()
            builder.string(Properties.target_name)
            builder.string(Properties.target_location)
            builder.string(Properties.target_photo)
            builder.int(Properties.target_security)
        }
    }
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

extension Target: JSONRepresentable{
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Properties.id, id)
        try json.set(Properties.target_name, target_name)
        try json.set(Properties.target_location, target_location)
        try json.set(Properties.target_photo, target_photo)
        try json.set(Properties.target_security, target_security)
        return json
    }
}

extension Target {
    var contract: Children<Target, Contract> {
        return children()
    }
}

extension Target: ResponseRepresentable {}

