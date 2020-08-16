import Fluent
import Vapor

struct FinanceMigrationSeed: Migration {
    
    func prepare(on db: Database) -> EventLoopFuture<Void> {
        let accounts = [FinanceAccountModel(name: "cash"), FinanceAccountModel(name: "capital")]
        return accounts.create(on: db)
    }
    
    func revert(on db: Database) -> EventLoopFuture<Void> {
        db.eventLoop.flatten([
            FinanceAccountModel.query(on: db).delete(),
        ])
    }
}
