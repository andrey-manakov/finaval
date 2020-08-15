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

    func boot(routes: RoutesBuilder, app: Application) throws {

        routes.get("example", use: self.controller.exampleView)
    }
}
