import Alamofire

final class AuthenticationHandler {
    enum APIErrorResponseCode: Int, CaseIterable {
        case retryRequired = 402
        case headerLacking = 403
    }
    private let retryCount = 4
    
    private var isRefreshing = false
    
    private let session = Session()
}

extension AuthenticationHandler: RequestInterceptor {
    // if you want to add header, add in this function
    func adapt(_ urlRequest: URLRequest,
               for session: Session,
               completion: @escaping (Result<URLRequest, Error>) -> Void) {
        if let urlString = urlRequest.url?.absoluteString,
           urlString.hasPrefix(APIConstant.host) {
            var urlRequest = urlRequest
            
            urlRequest.setValue(AuthorizationToken.token,
                                forHTTPHeaderField: "Authorization")
            
            completion(.success(urlRequest))
            return
        }
        
        completion(.success(urlRequest))
    }
    
    // API retry function
    func retry(_ request: Request,
               for session: Session,
               dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse,
              let responseCode = APIErrorResponseCode(rawValue: response.statusCode) else {
                  completion(.doNotRetryWithError(error))
                  return
        }
        
        // exceed retry count limit
        guard request.retryCount < retryCount else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        guard !isRefreshing else { return }
        
        isRefreshing = true
        
        switch responseCode {
        case .retryRequired:
            isRefreshing = false
            completion(.retry)
        case .headerLacking:
            completion(.doNotRetry)
        }
    }
}
