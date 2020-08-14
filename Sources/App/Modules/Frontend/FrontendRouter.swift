//
//  FrontendRouter.swift
//  Frontend
//
//  Created by swift-template on 14.08.2020.
//

import Vapor
import ViperKit

final class FrontendRouter: ViperRouter {

    let controller = FrontendFrontendController()

    func boot(routes: RoutesBuilder, app: Application) throws {

        routes.get("example", use: self.controller.exampleView)
    }
}
