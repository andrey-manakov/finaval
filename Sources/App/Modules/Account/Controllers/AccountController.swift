import Vapor
import Fluent
import ViewKit

struct AccountController: ViperAdminViewController {

    typealias Module = AccountModule
    typealias EditForm = AccountEditForm
    typealias Model = AccountModel
    
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
