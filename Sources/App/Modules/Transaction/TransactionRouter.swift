//
//  AccountRouter.swift
//  Account
//
//  Created by swift-template on 15.08.2020.
//

import Vapor
import ViperKit

final class TransactionRouter: ViperRouter {

    let controller = TransactionController()

    func boot(routes: RoutesBuilder, app: Application) throws {

        self.controller.setupRoutes(routes: routes, on: "transactions")
        
    }
}
