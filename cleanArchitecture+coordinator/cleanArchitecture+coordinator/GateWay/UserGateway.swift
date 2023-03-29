import Foundation
import RxSwift

protocol UserRequestProtocol {
    func getUser() -> Observable<User>
}

class UserGateway: UserGatewayProtocol {
    var usersRequest: UserRequestProtocol!
    
    private let disposeBag = DisposeBag()
    
    func getUser(completion: @escaping (Result<User, Error>) -> Void) {
        usersRequest.getUser()
            .flatMap { response -> Observable<User> in
                if response != nil {
                    return Observable<User>.just(response)
                } else {
                    return Observable<User>.error(APIError.unknown)
                }
            }
            .subscribe( onNext: { value in
                completion(.success(value))
            }, onError: { error in
                completion(.failure(error))
            }, onCompleted: nil, onDisposed: nil )
            .disposed(by: disposeBag)
    }
}
