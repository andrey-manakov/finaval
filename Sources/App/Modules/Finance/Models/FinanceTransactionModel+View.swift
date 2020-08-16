import ViewKit

extension FinanceTransactionModel: ViewContextRepresentable {

    struct ViewContext: Encodable {
        var id: String
        var name: String

        init(model: FinanceTransactionModel) {
            self.id = model.id!.uuidString
            self.name = model.name
        }
    }

    var viewContext: ViewContext { .init(model: self) }
}

extension FinanceTransactionModel: FormFieldOptionRepresentable {
    var formFieldOption: FormFieldOption {
        .init(key: self.id!.uuidString, label: self.name)
    }
}
