
import Vapor
import Fluent
import ViperKit

final class FinanceAccountModel: ViperModel {
    typealias Module = FinanceModule

    static let name = "accounts"

    struct FieldKeys {
        static var name: FieldKey { "name" }
    }

    // MARK: - fields

    @ID() var id: UUID?
    @Field(key: FieldKeys.name) var name: String

    init() { }

    init(id: FinanceAccountModel.IDValue? = nil,
         name: String)
    {
        self.id = id
        self.name = name
    }
}
