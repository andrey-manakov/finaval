//
//  AccountMigration_v1_0_0.swift
//  Account
//
//  Created by swift-template on 15.08.2020.
//

import Vapor
import Fluent

struct TransactionMigration_v1_0_0: Migration {
    
    func prepare(on db: Database) -> EventLoopFuture<Void> {
        db.eventLoop.flatten([
            db.schema(TransactionModel.schema)
                .id()
                .field(TransactionModel.FieldKeys.amount, .int, .required)
                .field(TransactionModel.FieldKeys.fromAccountId, .uuid, .required)
                .field(TransactionModel.FieldKeys.toAccountId, .uuid, .required)
                .field(TransactionModel.FieldKeys.comment, .string)
                .foreignKey(TransactionModel.FieldKeys.fromAccountId,
                            references: AccountModel.schema,
                            .id,
                            onDelete: .cascade,
                            onUpdate: .cascade)
                .foreignKey(TransactionModel.FieldKeys.toAccountId,
                            references: AccountModel.schema,
                            .id,
                            onDelete: .cascade,
                            onUpdate: .cascade)
                .unique(on: TransactionModel.FieldKeys.comment)
                .create(),
        ])
    }
    
    func revert(on db: Database) -> EventLoopFuture<Void> {
        db.eventLoop.flatten([
            db.schema(TransactionModel.schema).delete(),
        ])
    }
}
