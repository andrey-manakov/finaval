import Fluent
import Vapor

struct AccountMigrationSeed: Migration {
    
//    private func transactions(_ amount: Int, from: AccountModel, to: AccountModel) -> [TransactionModel] {
//        [
//            .init(amount: amount, fromAccountId: from.id!, toAccountId: to.id!, comment: "test"),
//        ]
//    }
    
    func prepare(on db: Database) -> EventLoopFuture<Void> {
        let cashAccount = AccountModel(name: "cash")
        let capitalAccount = AccountModel(name: "capital")
        let accounts = [ cashAccount, capitalAccount]
        return accounts.create(on: db) //.flatMap { self.transactions(10, from: cashAccount, to: capitalAccount).create(on: db) }
    }
    
    func revert(on db: Database) -> EventLoopFuture<Void> {
        db.eventLoop.flatten([
            AccountModel.query(on: db).delete(),
        ])
    }
}
