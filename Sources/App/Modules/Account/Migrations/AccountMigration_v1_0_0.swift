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
                .field(AccountModel.FieldKeys.name, .string, .required)
                .unique(on: AccountModel.FieldKeys.name)
                .create(),
//            db.schema(FinanceTransactionModel.schema)
//                .id()
//                .field(FinanceTransactionModel.FieldKeys.amount, .int, .required)
//                .field(FinanceTransactionModel.FieldKeys.fromAccountId, .uuid, .required)
//                .field(FinanceTransactionModel.FieldKeys.toAccountId, .uuid, .required)
//                .field(FinanceTransactionModel.FieldKeys.comment, .string)
//                .foreignKey(FinanceTransactionModel.FieldKeys.fromAccountId,
//                            references: FinanceAccountModel.schema,
//                            .id,
//                            onDelete: .cascade,
//                            onUpdate: .cascade)
//                .foreignKey(FinanceTransactionModel.FieldKeys.toAccountId,
//                            references: FinanceAccountModel.schema,
//                            .id,
//                            onDelete: .cascade,
//                            onUpdate: .cascade)
//                .unique(on: FinanceTransactionModel.FieldKeys.comment)
//                .create(),
        ])
    }

    func revert(on db: Database) -> EventLoopFuture<Void> {
        db.eventLoop.flatten([
            db.schema(AccountModel.schema).delete(),
//            db.schema(TransactionModel.schema).delete(),
        ])
    }
}
