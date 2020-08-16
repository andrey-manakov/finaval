import Vapor
import ViewKit

final class FinanceTransactionEditForm: Form {
    typealias Model = FinanceTransactionModel

    struct Input: Decodable {
        var id: String
        var name: String
        var fromAccountId: String
        var toAccountId: String

    }

    var id: String? = nil
    var name = BasicFormField()
    var fromAccountId = SelectionFormField()
    var toAccountId = SelectionFormField()

    
    init() {}
    
    init(req: Request) throws {
        let context = try req.content.decode(Input.self)
        if !context.id.isEmpty {
            self.id = context.id
        }

        self.name.value = context.name
    }
    
    func write(to model: Model) {
        model.name = self.name.value
        model.$fromAccount.id = UUID(uuidString: self.fromAccountId.value)!
        model.$toAccount.id = UUID(uuidString: self.toAccountId.value)!
    }
    
    func read(from model: Model)  {
        self.id = model.id!.uuidString
        self.name.value = model.name
        self.fromAccountId.value = model.$fromAccount.id.uuidString
        self.toAccountId.value = model.$toAccount.id.uuidString
    }

    func validate(req: Request) -> EventLoopFuture<Bool> {
        var valid = true
        if self.name.value.isEmpty {
            self.name.error = "Name is required"
            valid = false
        }
        
        // FIXME: add validation fro toAccountId
        let fromAccountIdUuid = UUID(uuidString: self.fromAccountId.value)
        return FinanceAccountModel.find(fromAccountIdUuid, on: req.db)
        .map { model in
            if model == nil {
                self.fromAccountId.error = "Category identifier error"
                valid = false
            }
            return valid
        }
//        return req.eventLoop.future(valid)
    }
}
