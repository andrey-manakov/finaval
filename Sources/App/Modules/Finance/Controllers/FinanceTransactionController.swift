import Vapor
import Fluent
import ViewKit

struct FinanceTransactionController: ViperAdminViewController {

    typealias Module = FinanceModule
    typealias EditForm = FinanceTransactionEditForm
    typealias Model = FinanceTransactionModel
        
    func afterCreate(req: Request, form: EditForm, model: Model) -> EventLoopFuture<Response> {
        let response = req.redirect(to: "/\(Model.name)/")
        return req.eventLoop.makeSucceededFuture(response)
    }
    
    func afterUpdate(req: Request, form: EditForm, model: Model) -> EventLoopFuture<Response> {
        let response = req.redirect(to: "/\(Model.name)/")
        return req.eventLoop.makeSucceededFuture(response)
    }
    
    func listView(req: Request) throws -> EventLoopFuture<View> {
        
        struct TransactionWithAccounts: Encodable {
            var transaction: FinanceTransactionModel.ViewContext
            var fromAccount: FinanceAccountModel.ViewContext
            var toAccount: FinanceAccountModel.ViewContext
        }


        return FinanceTransactionModel.query(on: req.db)
//            .sort(\.$date, .descending)
            .with(\.$fromAccount)
            .with(\.$toAccount)
            .all()
            .mapEach { TransactionWithAccounts(transaction: $0.viewContext, fromAccount: $0.fromAccount.viewContext, toAccount: $0.toAccount.viewContext) }
            .flatMap {
                req.view.render(self.listView, ListContext($0))
            }
    }
}
