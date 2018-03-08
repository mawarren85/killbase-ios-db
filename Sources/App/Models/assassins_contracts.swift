
import FluentProvider

final class Assassin_Contract: Model {
    let storage = Storage()
    
    let contractId: Identifier?
    let assassinId: Identifier?
    
    struct Properties {
        static let id = "id"
        static let contractID = "contract_id"
        static let assassinID = "assassin_id"
    }
    
    init(contract: Contract, assassin: Assassin ) {
        self.contractId = contract.id
        self.assassinId = assassin.id
    }
    
    init(row: Row) throws {
        contractId = try row.get(Contract.foreignIdKey)
        assassinId = try row.get(Assassin.foreignIdKey)
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Contract.foreignIdKey, contractId)
        try row.set(Assassin.foreignIdKey, assassinId)
        return row
    }
}

extension Assassin_Contract: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) { builder in
            builder.id()
            builder.parent(Contract.self)
            builder.parent(Assassin.self)
        }
    }
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

extension Assassin_Contract: JSONRepresentable{
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Properties.id, id)
        try json.set(Properties.contractID, contractId)
        try json.set(Properties.assassinID, assassinId)
        return json
    }
}

extension Assassin_Contract {
    var contract: Parent<Assassin_Contract, Contract> {
        return parent(id: contractId)
    }
}

extension Assassin_Contract {
    var assassin: Parent<Assassin_Contract, Assassin> {
        return parent(id: assassinId)
    }
}

extension Assassin_Contract: ResponseRepresentable {}
