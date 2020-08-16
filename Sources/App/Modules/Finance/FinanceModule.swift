//
//  AccountModule.swift
//  Account
//
//  Created by swift-template on 15.08.2020.
//

import Vapor
import Fluent
import ViperKit

final class FinanceModule: ViperModule {

    static var name: String = "finance"

    var router: ViperRouter? { FinanceRouter() }

    var migrations: [Migration] {
        [
            FinanceMigration_v1_0_0(),
            FinanceMigrationSeed(),
        ]
    }
}
