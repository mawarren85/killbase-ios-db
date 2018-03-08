import FluentProvider

final class Assassin: Model {
    let storage = Storage()
    
    var full_name: String
    var weapon: String
    var contact_info: String
    var age: Int
    var price: Double
    var rating: Double
    var kills: Int
    var assassin_photo: String
    
    
    struct Properties {
        static var id = "id"
        static var full_name = "full_name"
        static var weapon = "weapon"
        static var contact_info = "contact_info"
        static var age = "age"
        static var price = "price"
        static var rating = "rating"
        static var kills = "kills"
        static var assassin_photo = "assassin_photo"
    }
    
    init(full_name: String, weapon: String, contact_info: String, age: Int, price: Double, rating: Double, kills: Int, assassin_photo: String ) {
        self.full_name = full_name
        self.weapon = weapon
        self.contact_info = contact_info
        self.age = age
        self.price = price
        self.rating = rating
        self.kills = kills
        self.assassin_photo = assassin_photo
    }
    
    init(row: Row) throws {
       full_name = try row.get(Properties.full_name)
        weapon = try row.get(Properties.weapon)
        contact_info = try row.get(Properties.contact_info)
        age = try row.get(Properties.age)
        price = try row.get(Properties.price)
        rating = try row.get(Properties.rating)
        kills = try row.get(Properties.kills)
        assassin_photo = try row.get(Properties.assassin_photo)
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Properties.full_name, full_name)
        try row.set(Properties.weapon, weapon)
        try row.set(Properties.contact_info, contact_info)
        try row.set(Properties.age, age)
        try row.set(Properties.price, price)
        try row.set(Properties.rating, rating)
        try row.set(Properties.kills, kills)
        try row.set(Properties.assassin_photo, assassin_photo)
        return row
    }
}

extension Assassin: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) { builder in
            builder.id()
            builder.string(Properties.full_name)
            builder.string(Properties.weapon)
            builder.string(Properties.contact_info)
            builder.int(Properties.age)
            builder.double(Properties.price)
            builder.double(Properties.rating)
            builder.int(Properties.kills)
            builder.string(Properties.assassin_photo)
        }
    }
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

extension Assassin: JSONRepresentable{
//    convenience init(json: JSON) throws {
//        try self.init(full_name: json.get(Properties.full_name))
//        try self.init(weapon: json.get(Properties.weapon))
//        try self.init(contact_info: json.get(Properties.contact_info))
//        try self.init(age: json.get(Properties.age))
//        try self.init(price: json.get(Properties.price))
//        try self.init(rating: json.get(Properties.rating))
//        try self.init(kills: json.get(Properties.kills))
//        try self.init(assassin_photo: json.get(Properties.assassin_photo))
//    }
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Properties.id, id)
        try json.set(Properties.full_name, full_name)
        try json.set(Properties.weapon, weapon)
        try json.set(Properties.contact_info, contact_info)
        try json.set(Properties.age, age)
        try json.set(Properties.price, price)
        try json.set(Properties.rating, rating)
        try json.set(Properties.kills, kills)
        try json.set(Properties.assassin_photo, assassin_photo)
        return json
    }
}

extension Assassin {
    var codename: Children<Assassin, Codename> {
        return children()
    }
}

extension Assassin {
    var contract: Children<Assassin, Contract> {
        return children()
    }
}

extension Assassin {
    var contracts: Siblings<Assassin, Contract, Pivot<Assassin, Contract>> {
        return siblings()
    }
}

extension Assassin: ResponseRepresentable {}
