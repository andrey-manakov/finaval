import ViewKit

extension AccountModel: ViewContextRepresentable {

    struct ViewContext: Encodable {
        var id: String
        var name: String

        init(model: AccountModel) {
            self.id = model.id!.uuidString
            self.name = model.name
        }
    }

    var viewContext: ViewContext { .init(model: self) }
}

extension AccountModel: FormFieldOptionRepresentable {
    var formFieldOption: FormFieldOption {
        .init(key: self.id!.uuidString, label: self.name)
    }
}
