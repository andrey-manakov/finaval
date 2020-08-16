//
//  AccountMigration_v1_0_0.swift
//  Account
//
//  Created by swift-template on 15.08.2020.
//

import Vapor
import Fluent

struct FinanceMigration_v1_0_0: Migration {

    func prepare(on db: Database) -> EventLoopFuture<Void> {
        db.eventLoop.flatten([
            db.schema(FinanceAccountModel.schema)
                .id()
                .field(FinanceAccountModel.FieldKeys.name, .string, .required)
                .unique(on: FinanceAccountModel.FieldKeys.name)
                .create(),
            db.schema(FinanceTransactionModel.schema)
                .id()
                .field(FinanceTransactionModel.FieldKeys.name, .string, .required)
                .unique(on: FinanceTransactionModel.FieldKeys.name)
                .create(),
        ])
    }

    func revert(on db: Database) -> EventLoopFuture<Void> {
        db.eventLoop.flatten([
            db.schema(FinanceAccountModel.schema).delete(),
            db.schema(FinanceTransactionModel.schema).delete(),
        ])
    }
}
