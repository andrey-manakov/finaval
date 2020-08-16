
import Vapor
import Fluent
import ViperKit

final class FinanceTransactionModel: ViperModel {
    typealias Module = FinanceModule

    static let name = "transactions"

    struct FieldKeys {
        static var comment: FieldKey { "comment" }
        static var fromAccountId: FieldKey { "from_account_id" }
        static var toAccountId: FieldKey { "to_account_id" }
    }

    // MARK: - fields

    @ID() var id: UUID?
    @Field(key: FieldKeys.comment) var comment: String
    @Parent(key: FieldKeys.fromAccountId) var fromAccount: FinanceAccountModel
    @Parent(key: FieldKeys.toAccountId) var toAccount: FinanceAccountModel

    init() { }

    init(id: FinanceTransactionModel.IDValue? = nil,
         name: String,
         fromAccountId: UUID,
         toAccountId: UUID)
    {
        self.id = id
        self.comment = name
        self.$fromAccount.id = fromAccountId
        self.$toAccount.id = toAccountId
    }
}
