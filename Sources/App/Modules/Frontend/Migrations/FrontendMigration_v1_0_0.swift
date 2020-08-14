//
//  FrontendMigration_v1_0_0.swift
//  Frontend
//
//  Created by swift-template on 14.08.2020.
//

import Vapor
import Fluent

struct FrontendMigration_v1_0_0: Migration {

    func prepare(on db: Database) -> EventLoopFuture<Void> {
        db.eventLoop.flatten([
            db.schema(FrontendModel.schema)
                .id()
                .field(FrontendModel.FieldKeys.example, .string, .required)
                .unique(on: FrontendModel.FieldKeys.example)
                .create(),
        ])
    }

    func revert(on db: Database) -> EventLoopFuture<Void> {
        db.eventLoop.flatten([
            db.schema(FrontendModel.schema).delete(),
        ])
    }
}
