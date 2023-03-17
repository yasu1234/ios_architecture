import Alamofire
import RxSwift

struct AppsRequestFactory {
    static func createAppsRequest() -> AppsRequestProtocol {
        return AppsRequest()
    }
    
    static func createAppsRequestStub() -> AppsRequestProtocol {
        return AppsRequestStub()
    }
}

final class AppsRequest: APIRequest<App>, AppsRequestProtocol {
    func getApps() -> Observable<App> {
        let path = APIConstant.Route.app.rawValue
        
        return beginObjectRequest(path: path, method: .get, params: nil)
    }
    
}

final class AppsRequestStub: APIRequest<App>, AppsRequestProtocol {
    func getApps() -> Observable<App> {
        return Observable<App>.create { observable in
            let entity = App()
            entity.updateRequired = false
            
            observable.onNext(entity)
            
            return Disposables.create()
        }
    }
}
