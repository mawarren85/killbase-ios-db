import Vapor
import PostgreSQLProvider

extension Droplet {
    func setupRoutes() throws {
        let remindersController = RemindersController()
        remindersController.addRoutes(to: self)

        let usersController = UsersController()
        usersController.addRoutes(to: self)

        let categoriesController = CategoriesController()
        categoriesController.addRoutes(to: self)
        
        let assassinsController = AssassinsController()
        assassinsController.addRoutes(to: self)
        
        let contractsController = ContractsController()
        contractsController.addRoutes(to: self)
    }
}
