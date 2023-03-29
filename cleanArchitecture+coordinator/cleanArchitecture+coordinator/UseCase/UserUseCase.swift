import Foundation
import RxSwift

protocol UserUseCaseProtocol: AnyObject {
    func getUser()
    
    var output: UserUseCaseOutputProtocol! { get set }
    var userGateway: UserGatewayProtocol! { get set }
}

protocol UserUseCaseOutputProtocol: AnyObject {
    func didReceiveUser(_ user: User)
    func didReceiveError(_ error: Error)
    func didReceiveNetworkConnectionError()
}

protocol UserGatewayProtocol {
    func getUser(completion: @escaping (Result<User, Error>) -> Void)
}

final class UserUseCase: UserUseCaseProtocol {
    weak var output: UserUseCaseOutputProtocol!
    
    var userGateway: UserGatewayProtocol!
    
    func getUser() {
        userGateway.getUser { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let value):
                self.output.didReceiveUser(value)
            case .failure(let error):
                switch error {
                case APIError.error(let message, let type):
                    self.output.didReceiveError(APIError.error(message: message, type: type))
                case APIError.netWorkConnectionError:
                    self.output.didReceiveNetworkConnectionError()
                default:
                    self.output.didReceiveError(APIError.unknown)
                }
            }
        }
    }
}
