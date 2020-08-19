//
//  AccountModule.swift
//  Account
//
//  Created by swift-template on 15.08.2020.
//

import Vapor
import Fluent
import ViperKit

final class TransactionModule: ViperModule {

    static var name: String = "transaction"

    var router: ViperRouter? { TransactionRouter() }

    var migrations: [Migration] {
        [
            TransactionMigration_v1_0_0(),
//            AccountMigrationSeed(),
        ]
    }
}
