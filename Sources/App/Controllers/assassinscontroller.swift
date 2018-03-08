import Vapor
import FluentProvider
import PostgreSQLProvider


struct AssassinsController {
    func addRoutes(to drop: Droplet) {
        let assassinGroup = drop.grouped("assassins")
        assassinGroup.get(handler: allAssassins)
        assassinGroup.post("new", handler: newAssassin)
        assassinGroup.get(Assassin.parameter, handler: getAssassin)
        assassinGroup.put(Assassin.parameter, "edit", handler: editAssassin)
//        categoryGroup.get(Category.parameter, "reminders", handler: getCategorysReminders)
        assassinGroup.delete(Assassin.parameter, "delete", handler: deleteAssassin)
    }
    
    
    func newAssassin(_ req: Request) throws -> ResponseRepresentable {
        guard let json = req.json else {
            throw Abort.badRequest
        }
        let assassin = try Assassin(row: Row(json))
        try assassin.save()
        return assassin
    }
    
    
    func allAssassins(_ req: Request) throws -> ResponseRepresentable {
        let assassins = try Assassin.all()
        return try assassins.makeJSON()
    }
    
    
    func getAssassin(_ req: Request) throws -> ResponseRepresentable {
        let assassin = try req.parameters.next(Assassin.self)
        return assassin
    }
    
    
    func editAssassin(_ req: Request) throws -> ResponseRepresentable {
        
        let assassin = try req.parameters.next(Assassin.self)
       
        guard let full_name = req.data["full_name"]?.string,
            let weapon = req.data["weapon"]?.string,
            let contact_info = req.data["contact_info"]?.string,
            let age = req.data["age"]?.int,
            let price = req.data["price"]?.double,
            let rating = req.data["rating"]?.double,
            let kills = req.data["kills"]?.int,
            let assassin_photo = req.data["assassin_photo"]?.string else {
                throw Abort.badRequest
        }
        assassin.full_name = full_name
        assassin.weapon = weapon
        assassin.contact_info = contact_info
        assassin.age = age
        assassin.price = price
        assassin.rating = rating
        assassin.kills = kills
        assassin.assassin_photo = assassin_photo
        
        try assassin.save()
        return try assassin.makeJSON()
    }

 
    func deleteAssassin(_ req: Request) throws -> ResponseRepresentable {
        let assassin = try req.parameters.next(Assassin.self)
        try assassin.delete()
        return try Assassin.all().makeJSON()
    }
    
    
//    func getCategorysReminders(_ req: Request) throws -> ResponseRepresentable {
//        let category = try req.parameters.next(Category.self)
//        return try category.reminders.all().makeJSON()
//    }
}

