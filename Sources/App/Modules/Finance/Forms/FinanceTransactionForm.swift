import Vapor
import ViewKit

final class FinanceTransactionEditForm: Form {
    typealias Model = FinanceTransactionModel

    struct Input: Decodable {
        var id: String
        var name: String
    }

    var id: String? = nil
    var name = BasicFormField()
    
    init() {}
    
    init(req: Request) throws {
        let context = try req.content.decode(Input.self)
        if !context.id.isEmpty {
            self.id = context.id
        }

        self.name.value = context.name
    }
    
    func write(to model: Model) {
        model.name = self.name.value
    }
    
    func read(from model: Model)  {
        self.id = model.id!.uuidString
        self.name.value = model.name
    }

    func validate(req: Request) -> EventLoopFuture<Bool> {
        var valid = true
        if self.name.value.isEmpty {
            self.name.error = "Name is required"
            valid = false
        }
        return req.eventLoop.future(valid)
    }
}
