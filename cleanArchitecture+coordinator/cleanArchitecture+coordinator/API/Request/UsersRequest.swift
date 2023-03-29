import Alamofire
import RxSwift

struct UsersRequestFactory {
    static func createUsersRequest() -> UserRequestProtocol {
        return UsersRequest()
    }
    
    static func createUsersRequestStub() -> UserRequestProtocol {
        return UsersRequestStub()
    }
}

final class UsersRequest: APIRequest<User>, UserRequestProtocol {
    func getUser() -> Observable<User> {
        let path = APIConstant.Route.authenticatedUser.rawValue
        
        return beginObjectRequest(path: APIConstant.host + path, method: .get, params: nil)
    }
}

final class UsersRequestStub: APIRequest<User>, UserRequestProtocol {
    func getUser() -> Observable<User> {
        return Observable<User>.create { observable in
            let entity = User()
            observable.onNext(entity)
            
            return Disposables.create()
        }
    }
}
