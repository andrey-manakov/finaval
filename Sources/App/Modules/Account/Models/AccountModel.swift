//
//  AccountModel.swift
//  Account
//
//  Created by swift-template on 15.08.2020.
//

import Vapor
import Fluent
import ViperKit

final class AccountModel: ViperModel {
    typealias Module = AccountModule

    static let name = "examples"

    struct FieldKeys {
        static var example: FieldKey { "example" }
    }

    // MARK: - fields

    @ID() var id: UUID?
    @Field(key: FieldKeys.example) var example: String

    init() { }

    init(id: AccountModel.IDValue? = nil,
         example: String)
    {
        self.id = id
        self.example = example
    }
}
