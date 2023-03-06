import Alamofire

final class AuthenticationSession {
    static let session: Session = {
        let authenticationHandler = AuthenticationHandler()
        let configuration = URLSessionConfiguration.default
        
        configuration.timeoutIntervalForRequest = 120
        
        return Session(configuration: configuration, interceptor: authenticationHandler)
    }()
}
