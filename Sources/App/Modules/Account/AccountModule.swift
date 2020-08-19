//
//  AccountModule.swift
//  Account
//
//  Created by swift-template on 15.08.2020.
//

import Vapor
import Fluent
import ViperKit

final class AccountModule: ViperModule {

    static var name: String = "account"

    var router: ViperRouter? { AccountRouter() }

    var migrations: [Migration] {
        [
            AccountMigration_v1_0_0(),
            AccountMigrationSeed(),
        ]
    }
}
