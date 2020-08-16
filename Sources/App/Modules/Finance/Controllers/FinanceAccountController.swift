import Vapor
import Fluent
import ViewKit

struct FinanceAccountController: ViperAdminViewController {

    typealias Module = FinanceModule
    typealias EditForm = FinanceAccountEditForm
    typealias Model = FinanceAccountModel
    
    func afterCreate(req: Request, form: EditForm, model: Model) -> EventLoopFuture<Response> {
        let response = req.redirect(to: "/\(Model.name)/")
        return req.eventLoop.makeSucceededFuture(response)
    }
    
    func afterUpdate(req: Request, form: EditForm, model: Model) -> EventLoopFuture<Response> {
        let response = req.redirect(to: "/\(Model.name)/")
        return req.eventLoop.makeSucceededFuture(response)
//        self.render(req: req, form: form).encodeResponse(for: req)
    }

}
