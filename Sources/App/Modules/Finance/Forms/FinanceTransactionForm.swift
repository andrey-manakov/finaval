import Vapor
import ViewKit

final class FinanceTransactionEditForm: Form {
    typealias Model = FinanceTransactionModel

    struct Input: Decodable {
        var id: String
        var amount: String
        var fromAccountId: String
        var toAccountId: String
        var comment: String
    }

    var id: String? = nil
    var amount = BasicFormField()
    var comment = BasicFormField()
    var fromAccountId = SelectionFormField()
    var toAccountId = SelectionFormField()

    
    init() {}
    
    init(req: Request) throws {
        let context = try req.content.decode(Input.self)
        if !context.id.isEmpty {
            self.id = context.id
        }
        self.amount.value = "\(context.amount)"
        self.fromAccountId.value = context.fromAccountId
        self.toAccountId.value = context.toAccountId
        self.comment.value = context.comment
    }
    
    func write(to model: Model) {
        model.comment = self.comment.value
        model.$fromAccount.id = UUID(uuidString: self.fromAccountId.value)!
        model.$toAccount.id = UUID(uuidString: self.toAccountId.value)!
        guard let amount = Int(self.amount.value) else {
            fatalError("Non Int value in amount")
        }
        model.amount = amount
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
//        print("LOG validate int  amount in transaction from \(Int(self.amount.value))")
        if Int(self.amount.value) == nil {
            self.amount.error = "Amount is invalid"
            valid = false
        }
        
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
