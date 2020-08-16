import ViewKit

extension FinanceTransactionModel: ViewContextRepresentable {

    struct ViewContext: Encodable {
        var id: String
        var amount: Int
        var comment: String

        init(model: FinanceTransactionModel) {
            self.id = model.id!.uuidString
            self.amount = model.amount
            self.comment = model.comment
        }
    }

    var viewContext: ViewContext { .init(model: self) }
}

extension FinanceTransactionModel: FormFieldOptionRepresentable {
    var formFieldOption: FormFieldOption {
        .init(key: self.id!.uuidString, label: self.comment)
    }
}
