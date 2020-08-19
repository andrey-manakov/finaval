//import Fluent
//import Vapor
//
//struct AccountMigrationSeed: Migration {
//    
//    func prepare(on db: Database) -> EventLoopFuture<Void> {
//        let accounts = [AccountModel(name: "cash"), AccountModel(name: "capital")]
//        return accounts.create(on: db)
//    }
//    
//    func revert(on db: Database) -> EventLoopFuture<Void> {
//        db.eventLoop.flatten([
//            AccountModel.query(on: db).delete(),
//        ])
//    }
//}
