import Fluent
import FluentSQLiteDriver
import Vapor
import ViperKit

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

//    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
    app.databases.use(.sqlite(), as: .sqlite)

//    app.migrations.add(CreateTodo())

    // register routes
//    try routes(app)
    
    let modules: [ViperModule] = [
//        UserModule(),
        FrontendModule(),
//        AdminModule(),
//        BlogModule(),
    ]

    try app.viper.use(modules)
    try app.autoMigrate().wait()

}
