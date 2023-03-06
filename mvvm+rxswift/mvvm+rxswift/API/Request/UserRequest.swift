import RxSwift

class UserRequest: APIRequest<User> {
    func get() -> Observable<User> {
        let path = APIConstant.Route.authenticatedUser.rawValue
        
        return beginObjectRequest(
            path: APIConstant.host + path,
            method: .get,
            params: nil
        )
    }
}
