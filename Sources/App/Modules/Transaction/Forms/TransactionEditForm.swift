import Vapor
import ViewKit

final class TransactionEditForm: Form {
    typealias Model = TransactionModel

    struct Input: Decodable {
        var id: String
        var amount: String
        var fromAccountId: String
//        var fromAccountName: String
        var toAccountId: String
//        var toAccountName: String
        var comment: String
        var accounts: [String]
    }

    var id: String? = nil
    var amount = BasicFormField()
    var fromAccountId = SelectionFormField()
    var fromAccountName: String?
    var toAccountId = SelectionFormField()
    var toAccountName: String?
    var comment = BasicFormField()
    
    deinit {
        print("LOG deinit \(self)")
    }
    
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
//        self.accounts.values = context.accounts
    }
    
    func write(to model: Model) {
        model.comment = self.comment.value
        model.fromAccountId = UUID(uuidString: self.fromAccountId.value)!
        model.fromAccountName = self.fromAccountName ?? ""
        model.toAccountId = UUID(uuidString: self.toAccountId.value)!
        model.toAccountName = self.toAccountName ?? ""
        print("LOG write fromAccountName \(fromAccountName)")
        print("LOG write toAccountName \(toAccountName)")
        guard let amount = Int(self.amount.value) else {
            fatalError("Non Int value in amount")
        }
        model.amount = amount
    }
    
    func read(from model: Model)  {
        self.id = model.id!.uuidString
        self.amount.value = "\(model.amount)"
        self.fromAccountId.value = model.fromAccountId.uuidString
        self.toAccountId.value = model.toAccountId.uuidString
        self.comment.value = model.comment
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
        let fromAccountName: EventLoopFuture<String?>  = AccountModel.find(fromAccountIdUuid, on: req.db).map { $0?.name }
        let toAccountIdUuid = UUID(uuidString: self.toAccountId.value)
        let toAccountName: EventLoopFuture<String?>  = AccountModel.find(toAccountIdUuid, on: req.db).map { $0?.name }
        print("LOG fromAccountIdUuid \(fromAccountIdUuid)")
        print("LOG toAccountIdUuid \(toAccountIdUuid)")
//        let fromAccountIdValid: EventLoopFuture<Bool> = AccountModel.find(fromAccountIdUuid, on: req.db)
//            .map { model in
//                guard let model = model else {
//                    self.fromAccountId.error = "Category identifier error"
//                    valid = false
//                    return false
//                }
//                self.fromAccountName = model.name
//                return true
//        }

//        let toAccountIdUuid = UUID(uuidString: self.toAccountId.value)
//        let toAccountIdValid: EventLoopFuture<Bool> = AccountModel.find(toAccountIdUuid, on: req.db)
//            .map { model in
//                if model == nil {
//                    self.toAccountId.error = "Category identifier error"
//                    valid = false
//                    return false
//                }
//
//                return true //valid
//        }
//        FIXME: unowned self
        return fromAccountName.and(toAccountName).map { fromAccountName, toAccountName in
            print("LOG fromAccountName \(fromAccountName)")
            print("LOG toAccountName \(toAccountName)")
            self.fromAccountName = fromAccountName
            self.toAccountName = toAccountName
            return valid && fromAccountName != nil && toAccountName != nil
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
