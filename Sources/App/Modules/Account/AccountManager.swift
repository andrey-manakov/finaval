import Vapor

typealias AccountId = UUID
typealias AccountName = String

protocol AccountMaangerProtocol {
    func getAccounts(req: Request) -> EventLoopFuture<[AccountId: AccountName]>
    func getAccountName(id: UUID, req: Request) -> EventLoopFuture<String?>
}

struct AccountManager: AccountMaangerProtocol {
    func getAccounts(req: Request) -> EventLoopFuture<[AccountId: AccountName]> {
        AccountModel.query(on: req.db).all().map { Dictionary(uniqueKeysWithValues: $0.map { ($0.id!, $0.name) }) }
    }
    func getAccountName(id: UUID, req: Request) -> EventLoopFuture<String?> {
        AccountModel.find(id, on: req.db).map { $0?.name }
    }
    
}
