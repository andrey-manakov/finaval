//
//  FrontendModel.swift
//  Frontend
//
//  Created by swift-template on 14.08.2020.
//

import Vapor
import Fluent
import ViperKit

final class FrontendModel: ViperModel {
    typealias Module = FrontendModule

    static let name = "examples"

    struct FieldKeys {
        static var example: FieldKey { "example" }
    }

    // MARK: - fields

    @ID() var id: UUID?
    @Field(key: FieldKeys.example) var example: String

    init() { }

    init(id: FrontendModel.IDValue? = nil,
         example: String)
    {
        self.id = id
        self.example = example
    }
}
