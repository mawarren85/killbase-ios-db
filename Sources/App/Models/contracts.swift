import FluentProvider

final class Contract: Model {
    
    let storage = Storage()
    var targetId: Identifier?
    var clientId: Identifier?
    var budget: Int
    var completed: Bool
    var assassinId: Identifier?
    
    struct Properties {
        static var id = "id"
        static var targetID = "target_id"
        static var clientID = "client_id"
        static var budget = "budget"
        static var completed = "completed"
        static var assassinID = "assassin_id"
    }
    
    
    init(target: Target, client: Client, budget: Int, completed: Bool, assassin: Assassin) {
        self.targetId = target.id
        self.clientId = client.id
        self.budget = budget
        self.completed = completed
        self.assassinId = assassin.id
    }
    
    init(row: Row) throws {
        targetId = try row.get(Target.foreignIdKey)
        clientId = try row.get(Client.foreignIdKey)
        budget = try row.get(Properties.budget)
        completed = try row.get(Properties.completed)
        assassinId = try row.get(Assassin.foreignIdKey)
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Target.foreignIdKey, targetId)
        try row.set(Client.foreignIdKey, clientId)
        try row.set(Properties.budget, budget)
        try row.set(Properties.completed, completed)
        try row.set(Assassin.foreignIdKey, assassinId)
        return row
    }
}

extension Contract: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) { builder in
            builder.id()
            builder.parent(Target.self)
            builder.parent(Client.self)
            builder.int(Properties.budget)
            builder.bool(Properties.completed)
            builder.parent(Assassin.self)
        }
    }
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

extension Contract: JSONRepresentable{
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Properties.id, id)
        try json.set(Properties.targetID, targetId)
        try json.set(Properties.clientID, clientId)
        try json.set(Properties.budget, budget)
        try json.set(Properties.completed, completed)
        try json.set(Properties.assassinID, assassinId)
        return json
    }
}


extension Contract {
    var target: Parent<Contract, Target> {
        return parent(id: targetId)
    }
}

extension Contract {
    var client: Parent<Contract, Client> {
        return parent(id: clientId)
    }
}

extension Contract {
    var assassin: Parent<Contract, Assassin> {
        return parent(id: assassinId)
    }
}

extension Contract {
    var assassins: Siblings<Contract, Assassin, Pivot<Contract, Assassin>> {
        return siblings()
    }
}



extension Contract: ResponseRepresentable {}
