//
//  FrontendModule.swift
//  Frontend
//
//  Created by swift-template on 14.08.2020.
//

import Vapor
import Fluent
import ViperKit

final class FrontendModule: ViperModule {

    static var name: String = "frontend"

    var router: ViperRouter? { FrontendRouter() }

    var migrations: [Migration] {
        [
            FrontendMigration_v1_0_0(),
        ]
    }
}
