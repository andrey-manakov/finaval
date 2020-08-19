//import Fluent
//import Vapor
//
//struct FinanceMigrationSeed: Migration {
//    
//    private func transactions(_ amount: Int, from: FinanceAccountModel, to: FinanceAccountModel) -> [FinanceTransactionModel] {
//        [
//            .init(amount: amount, fromAccountId: from.id!, toAccountId: to.id!, comment: "test"),
//        ]
//    }
//    
//    func prepare(on db: Database) -> EventLoopFuture<Void> {
//        let cashAccount = FinanceAccountModel(name: "cash")
//        let capitalAccount = FinanceAccountModel(name: "capital")
//        let accounts = [ cashAccount, capitalAccount]
//        return accounts.create(on: db).flatMap { self.transactions(10, from: cashAccount, to: capitalAccount).create(on: db) }
//    }
//    
//    func revert(on db: Database) -> EventLoopFuture<Void> {
//        db.eventLoop.flatten([
//            FinanceAccountModel.query(on: db).delete(),
//        ])
//    }
//}
