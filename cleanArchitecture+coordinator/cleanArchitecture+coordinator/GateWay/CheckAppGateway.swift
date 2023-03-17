import Foundation
import RxSwift

protocol AppsRequestProtocol {
    func getApps() -> Observable<App>
}

class CheckAppGateway: AppUpdateGatewayProtocol {
    
    var appUpdateRequest: AppsRequestProtocol!
    
    private let disposeBag = DisposeBag()
    
    func getApps(completion: @escaping (Result<App, Error>) -> Void) {
        appUpdateRequest.getApps()
            .flatMap { response -> Observable<App> in
                if response != nil {
                    return Observable<App>.just(response)
                } else {
                    return Observable<App>.error(APIError.unknown)
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
