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
    var comment = BasicFormField()
    var fromAccountId = SelectionFormField()
    var toAccountId = SelectionFormField()

    
    init() {}
    
    init(req: Request) throws {
        let context = try req.content.decode(Input.self)
        if !context.id.isEmpty {
            self.id = context.id
        }

        self.comment.value = context.name
        self.fromAccountId.value = context.fromAccountId
        self.toAccountId.value = context.toAccountId
    }
    
    func write(to model: Model) {
        model.comment = self.comment.value
        model.$fromAccount.id = UUID(uuidString: self.fromAccountId.value)!
        model.$toAccount.id = UUID(uuidString: self.toAccountId.value)!
    }
    
    func read(from model: Model)  {
        self.id = model.id!.uuidString
        self.comment.value = model.comment
        self.fromAccountId.value = model.$fromAccount.id.uuidString
        self.toAccountId.value = model.$toAccount.id.uuidString
    }

    func validate(req: Request) -> EventLoopFuture<Bool> {
        var valid = true
//        if self.comment.value.isEmpty {
//            self.comment.error = "Comment is required"
//            valid = false
//        }
        
        // FIXME: add validation fro toAccountId
        print("LOG \(self.fromAccountId.value)")
        let fromAccountIdUuid = UUID(uuidString: self.fromAccountId.value)
        let fromAccountIdValid: EventLoopFuture<Bool> = FinanceAccountModel.find(fromAccountIdUuid, on: req.db)
            .map { model in
                if model == nil {
                    self.fromAccountId.error = "Category identifier error"
                    valid = false
                    return false
                }
                return true //valid
        }

        let toAccountIdUuid = UUID(uuidString: self.toAccountId.value)
        let toAccountIdValid: EventLoopFuture<Bool> = FinanceAccountModel.find(toAccountIdUuid, on: req.db)
            .map { model in
                if model == nil {
                    self.toAccountId.error = "Category identifier error"
                    valid = false
                    return false
                }
                return true //valid
        }

        return fromAccountIdValid.and(toAccountIdValid).map { fromAccountIdValid, toAccountIdValid in
            valid && toAccountIdValid && fromAccountIdValid
        }
        
        

//        return FinanceAccountModel.find(fromAccountIdUuid, on: req.db)
//        .map { model in
//            if model == nil {
//                self.fromAccountId.error = "Category identifier error"
//                valid = false
//            }
//            return valid
//        }
//        return req.eventLoop.future(valid)
    }
}
