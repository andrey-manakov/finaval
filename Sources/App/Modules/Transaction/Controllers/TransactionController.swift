import Vapor
import Fluent
import ViewKit

struct TransactionController: ViperAdminViewController {

    typealias Module = TransactionModule
    typealias EditForm = TransactionEditForm
    typealias Model = TransactionModel
    
    var accountManager: AccountManagerProtocol
    
    init(with accountManager: AccountMaangerProtocol = AccountManager()) {
        self.accountManager = accountManager
    }
    
    func beforeRender(req: Request, form: TransactionEditForm) -> EventLoopFuture<Void> {
        accountManager.getAccounts(req: req).map {
            form.fromAccountId.options = $0.map { FormFieldOption(key: $0.key.uuidString, label: $0.value) }
            form.toAccountId.options = $0.map { FormFieldOption(key: $0.key.uuidString, label: $0.value) }
        }
    }
        
    func afterCreate(req: Request, form: EditForm, model: Model) -> EventLoopFuture<Response> {
        let response = req.redirect(to: "/\(Model.name)/")
        return req.eventLoop.makeSucceededFuture(response)
    }
    
    func afterUpdate(req: Request, form: EditForm, model: Model) -> EventLoopFuture<Response> {
        let response = req.redirect(to: "/\(Model.name)/")
        return req.eventLoop.makeSucceededFuture(response)
    }
    
//    func listView(req: Request) throws -> EventLoopFuture<View> {
//        
//        struct TransactionWithAccounts: Encodable {
//            var transaction: TransactionModel.ViewContext
//            var fromAccount: AccountModel.ViewContext
//            var toAccount: AccountModel.ViewContext
//        }
//        
//        
//        return TransactionModel.query(on: req.db)
//            //            .sort(\.$date, .descending)
//            .with(\.$fromAccount)
//            .with(\.$toAccount)
//            .all()
//            .mapEach { TransactionWithAccounts(transaction: $0.viewContext, fromAccount: $0.fromAccount.viewContext, toAccount: $0.toAccount.viewContext) }
//            .flatMap {
//                req.view.render(self.listView, ListContext($0))
//        }
//    }

//    func listView(req: Request) throws -> EventLoopFuture<View> {
//        
//        struct TransactionWithAccounts: Encodable {
//            var transaction: TransactionModel.ViewContext
//            var fromAccount: AccountModel.ViewContext
//            var toAccount: AccountModel.ViewContext
//        }
//
//
//        return TransactionModel.query(on: req.db)
////            .sort(\.$date, .descending)
//            .with(\.$fromAccount)
//            .with(\.$toAccount)
//            .all()
//            .mapEach { TransactionWithAccounts(transaction: $0.viewContext, fromAccount: $0.fromAccount.viewContext, toAccount: $0.toAccount.viewContext) }
//            .flatMap {
//                req.view.render(self.listView, ListContext($0))
//            }
//    }
}
