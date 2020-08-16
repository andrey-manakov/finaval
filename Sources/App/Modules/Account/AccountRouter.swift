//
//  AccountRouter.swift
//  Account
//
//  Created by swift-template on 15.08.2020.
//

import Vapor
import ViperKit

final class AccountRouter: ViperRouter {

    let controller = AccountFrontendController()
    let accountAdminController = AccountAdminController()

    func boot(routes: RoutesBuilder, app: Application) throws {

        routes.get("account", use: self.controller.accountView)
        
        self.accountAdminController.setupRoutes(routes: routes, on: "accounts")
        
    }
}
