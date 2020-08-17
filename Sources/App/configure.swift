import Fluent
import FluentSQLiteDriver
import Vapor
import ViewKit
import ViperKit

// configures your application
public func configure(_ app: Application) throws {

//    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
    app.databases.use(.sqlite(), as: .sqlite)
    
    // enable access in local network
//    let serverConfig = NIOServerConfig.default(hostname: "0.0.0.0")
//    services.register(serverConfig)

    // register routes
    try routes(app)
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.views.use(.leaf)
    if !app.environment.isRelease {
        app.leaf.cache.isEnabled = false
        app.leaf.useViperViews()
    }
    
    let modules: [ViperModule] = [
//        FinanceModule(),
    ]

    try app.viper.use(modules)
    try app.autoMigrate().wait()

}

protocol ViperAdminViewController: AdminViewController where Model: ViperModel  {
    associatedtype Module: ViperModule
}

extension `ViperAdminViewController` {

    var listView: String { "\(Module.name.capitalized)/\(Model.name.capitalized)/List" }
    var editView: String { "\(Module.name.capitalized)/\(Model.name.capitalized)/Edit" }
}

extension Fluent.Model where IDValue == UUID {
    var viewIdentifier: String { self.id!.uuidString }
}
