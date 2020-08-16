import ViewKit

extension FinanceAccountModel: ViewContextRepresentable {

    struct ViewContext: Encodable {
        var id: String
        var name: String

        init(model: FinanceAccountModel) {
            self.id = model.id!.uuidString
            self.name = model.name
        }
    }

    var viewContext: ViewContext { .init(model: self) }
}

extension FinanceAccountModel: FormFieldOptionRepresentable {
    var formFieldOption: FormFieldOption {
        .init(key: self.id!.uuidString, label: self.name)
    }
}
