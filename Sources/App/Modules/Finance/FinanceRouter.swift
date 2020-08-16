//
//  AccountRouter.swift
//  Account
//
//  Created by swift-template on 15.08.2020.
//

import Vapor
import ViperKit

final class FinanceRouter: ViperRouter {

    let accountController = FinanceAccountController()
    let transactionController = FinanceTransactionController()

    func boot(routes: RoutesBuilder, app: Application) throws {
        self.accountController.setupRoutes(routes: routes, on: "accounts")
        self.transactionController.setupRoutes(routes: routes, on: "transactions")
    }
}
