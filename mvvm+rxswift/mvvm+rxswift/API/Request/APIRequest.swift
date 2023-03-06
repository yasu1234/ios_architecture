import Alamofire
import ObjectMapper
import RxAlamofire
import RxSwift

class APIRequest<T: Mappable> {
    private var request: Alamofire.Request? {
        didSet {
            oldValue?.cancel()
        }
    }
    
    private let session = AuthenticationSession.session
    
    private func beginRequest<T: Mappable>(
        path: String,
        method: HTTPMethod,
        params: [String: Any]?
    ) -> Observable<T> {
        var encoding: ParameterEncoding = JSONEncoding.default
        
        if method == .put {
            encoding = URLEncoding.queryString
        }
        
        return session.rx.request(
            method,
            path,
            parameters: params,
            encoding: encoding,
            headers: nil)
            .validate(statusCode: validateStatusCodes)
            .validate(contentType: ["application/json"])
            .responseMappable(as: T.self)
    }
    
    private var validateStatusCodes: [Int] {
        var statusCodeArray = [Int]()
        statusCodeArray += 200...599
        
        for item in AuthenticationHandler.APIErrorResponseCode.allCases {
            if let index = statusCodeArray.firstIndex(of: item.rawValue),
               statusCodeArray.count > index {
                statusCodeArray.remove(at: index)
            }
        }
        return statusCodeArray
    }
}

extension APIRequest {
    func beginObjectRequest(path: String, method: HTTPMethod, params: [String: Any]?) -> Observable<T> {
        return beginRequest(path: path, method: method, params: params)
    }
}
