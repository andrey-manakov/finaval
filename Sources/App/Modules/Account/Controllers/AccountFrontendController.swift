//
//  AccountFrontendController.swift
//  Account
//
//  Created by swift-template on 15.08.2020.
//

import Vapor
import Fluent

final class AccountFrontendController {

    func accountView(req: Request) throws -> EventLoopFuture<View> {
        struct Context: Encodable {
            let foo: String
        }
        let context = Context(foo: "This is just an example")
        return req.view.render("Account/Frontend/Example", context)
    }

}
