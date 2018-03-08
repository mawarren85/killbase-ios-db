import Vapor
import FluentProvider
import PostgreSQLProvider


struct ContractsController {
    func addRoutes(to drop: Droplet) {
        let contractGroup = drop.grouped("contracts")
        contractGroup.get(handler: allContracts)
        contractGroup.post("new", handler: newContract)
        contractGroup.get(Contract.parameter, handler: getContract)
        contractGroup.put(Contract.parameter, "edit", handler: editContract)
        //        categoryGroup.get(Category.parameter, "reminders", handler: getCategorysReminders)
        contractGroup.delete(Contract.parameter, "delete", handler: deleteContract)
    }
    
    
    func newContract(_ req: Request) throws -> ResponseRepresentable {
        guard let json = req.json else {
            throw Abort.badRequest
        }
        let contract = try Contract(row: Row(json))
        try contract.save()
        return contract
    }
    
    
    func allContracts(_ req: Request) throws -> ResponseRepresentable {
        let contracts = try Contract.all()
        return try contracts.makeJSON()
    }
    
    
    func getContract(_ req: Request) throws -> ResponseRepresentable {
        let contract = try req.parameters.next(Contract.self)
        return contract
    }
    

    func editContract(_ req: Request) throws -> ResponseRepresentable {
        let contract = try req.parameters.next(Contract.self)
        
        let targetIdPassed = req.data["target_id"]?.int
        let targetIdIdentifier : Identifier = Identifier(targetIdPassed!)
        
        let clientIdPassed = req.data["client_id"]?.int
        let clientIdIdentifier : Identifier = Identifier(clientIdPassed!)
        
        let assassinIdPassed = req.data["assassin_id"]?.int
        let assassinIdIdentifier : Identifier = Identifier(assassinIdPassed!)

        let budget = req.data["budget"]?.int
        
        let completed = req.data["completed"]?.bool
   

        contract.targetId = targetIdIdentifier
        contract.clientId = clientIdIdentifier
        contract.budget = budget!
        contract.completed = completed!
        contract.assassinId = assassinIdIdentifier
     
        
        try contract.save()
        return try contract.makeJSON()
    }
    
    
    func deleteContract(_ req: Request) throws -> ResponseRepresentable {
        let contract = try req.parameters.next(Contract.self)
        try contract.delete()
        return try Contract.all().makeJSON()
    }
    
    
    //    func getCategorysReminders(_ req: Request) throws -> ResponseRepresentable {
    //        let category = try req.parameters.next(Category.self)
    //        return try category.reminders.all().makeJSON()
    //    }
}

