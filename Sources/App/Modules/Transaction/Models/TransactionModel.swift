
import Vapor
import Fluent
import ViperKit

final class TransactionModel: ViperModel {
    typealias Module = TransactionModule
    
    static let name = "transactions"
    
    struct FieldKeys {
        static var amount: FieldKey { "amount" }
        static var fromAccountId: FieldKey { "from_account_id" }
        static var toAccountId: FieldKey { "to_account_id" }
        static var comment: FieldKey { "comment" }
    }
    
    // MARK: - fields
    
    @ID() var id: UUID?
    @Field(key: FieldKeys.amount) var amount: Int
    @Parent(key: FieldKeys.fromAccountId) var fromAccount: AccountModel
    @Parent(key: FieldKeys.toAccountId) var toAccount: AccountModel
    @Field(key: FieldKeys.comment) var comment: String
    
    init() { }
    
    init(id: TransactionModel.IDValue? = nil,
         amount: Int,
         fromAccountId: UUID,
         toAccountId: UUID,
         comment: String)
    {
        self.id = id
        self.amount = amount
        self.$fromAccount.id = fromAccountId
        self.$toAccount.id = toAccountId
        self.comment = comment
    }
}
