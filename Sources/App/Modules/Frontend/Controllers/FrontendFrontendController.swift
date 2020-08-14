//
//  FrontendFrontendController.swift
//  Frontend
//
//  Created by swift-template on 14.08.2020.
//

import Vapor
import Fluent

final class FrontendFrontendController {

    func exampleView(req: Request) throws -> EventLoopFuture<View> {
        struct Context: Encodable {
            let foo: String
        }
        let context = Context(foo: "This is just an example")
        return req.view.render("Frontend/Frontend/Example", context)
    }

}
