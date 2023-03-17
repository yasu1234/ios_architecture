import Foundation
import RxSwift

protocol LaunchUseCaseProtocol: AnyObject {
    func checkAppContinue()
    
    var output: LaunchUseCaseOutputProtocol! { get set }
    var appUpdateGateway: AppUpdateGatewayProtocol! { get set }
}

protocol LaunchUseCaseOutputProtocol: AnyObject {
    func continuingAppAllowed()
    func continuingAppDisallowed(_ app: App)
    func didReceiveError(_ error: Error)
    func didReceiveNetworkConnectionError()
}

protocol AppUpdateGatewayProtocol {
    func getApps(completion: @escaping (Result<App, Error>) -> Void)
}

protocol AnnouncementGatewayProtocol {
    func get(completion: @escaping (Result<[App]?, Error>) -> Void)
}

final class LaunchUseCase: LaunchUseCaseProtocol {
    weak var output: LaunchUseCaseOutputProtocol!
    var appUpdateGateway: AppUpdateGatewayProtocol!
    
    func checkAppContinue() {
        appUpdateGateway.getApps { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let value):
                value.updateRequired ? self.output.continuingAppDisallowed(value) : self.output.continuingAppAllowed()
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
