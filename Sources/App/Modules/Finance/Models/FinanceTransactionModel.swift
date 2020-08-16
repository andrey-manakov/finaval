
import Vapor
import Fluent
import ViperKit

final class FinanceTransactionModel: ViperModel {
    typealias Module = FinanceModule

    static let name = "transactions"

    struct FieldKeys {
        static var name: FieldKey { "name" }
    }

    // MARK: - fields

    @ID() var id: UUID?
    @Field(key: FieldKeys.name) var name: String

    init() { }

    init(id: FinanceTransactionModel.IDValue? = nil,
         name: String)
    {
        self.id = id
        self.name = name
    }
}
