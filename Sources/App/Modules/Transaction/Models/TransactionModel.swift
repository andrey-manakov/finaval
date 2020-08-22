
import Vapor
import Fluent
import ViperKit

final class TransactionModel: ViperModel {
    typealias Module = TransactionModule
    
    static let name = "transactions"
    
    struct FieldKeys {
        static var amount: FieldKey { "amount" }
        static var fromAccountId: FieldKey { "from_account_id" }
        static var fromAccountName: FieldKey { "from_account_name" }
        static var toAccountId: FieldKey { "to_account_id" }
        static var toAccountName: FieldKey { "to_account_name" }
        static var comment: FieldKey { "comment" }
    }
    
    // MARK: - fields
    
    @ID() var id: UUID?
    @Field(key: FieldKeys.amount) var amount: Int
//    @Parent(key: FieldKeys.fromAccountId) var fromAccount: AccountModel
//    @Parent(key: FieldKeys.toAccountId) var toAccount: AccountModel
    @Field(key: FieldKeys.fromAccountId) var fromAccountId: UUID
    @Field(key: FieldKeys.fromAccountName) var fromAccountName: String
    @Field(key: FieldKeys.toAccountId) var toAccountId: UUID
    @Field(key: FieldKeys.toAccountName) var toAccountName: String
    @Field(key: FieldKeys.comment) var comment: String
    
    init() { }
    
    init(id: TransactionModel.IDValue? = nil,
         amount: Int,
         fromAccountId: UUID,
         fromAccountName: String,
         toAccountId: UUID,
         toAccountName: String,
         comment: String)
    {
        self.id = id
        self.amount = amount
        self.fromAccountId = fromAccountId
        self.fromAccountName = fromAccountName
        self.toAccountId = toAccountId
        self.toAccountName = toAccountName
        self.comment = comment
    }
}
