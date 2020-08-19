
import Vapor
import Fluent
import ViperKit

final class AccountModel: ViperModel {
    typealias Module = AccountModule

    static let name = "accounts"

    struct FieldKeys {
        static var name: FieldKey { "name" }
    }

    // MARK: - fields

    @ID() var id: UUID?
    @Field(key: FieldKeys.name) var name: String

    init() { }

    init(id: AccountModel.IDValue? = nil,
         name: String)
    {
        self.id = id
        self.name = name
    }
}
