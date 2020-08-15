//
//  AccountMigration_v1_0_0.swift
//  Account
//
//  Created by swift-template on 15.08.2020.
//

import Vapor
import Fluent

struct AccountMigration_v1_0_0: Migration {

    func prepare(on db: Database) -> EventLoopFuture<Void> {
        db.eventLoop.flatten([
            db.schema(AccountModel.schema)
                .id()
                .field(AccountModel.FieldKeys.example, .string, .required)
                .unique(on: AccountModel.FieldKeys.example)
                .create(),
        ])
    }

    func revert(on db: Database) -> EventLoopFuture<Void> {
        db.eventLoop.flatten([
            db.schema(AccountModel.schema).delete(),
        ])
    }
}
