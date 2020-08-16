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

}
