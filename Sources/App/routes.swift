import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in req.redirect(to: "/accounts/") }
//    app.get("test", use: <#T##(Request) throws -> ResponseEncodable#>)
}
