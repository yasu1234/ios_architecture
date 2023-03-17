import Foundation

protocol LaunchPresenterProtocol: AnyObject {
    func checkAppContinue()
}

protocol LaunchPresenterOutputProtocol: AnyObject {
    func continueAppLaunching()
    func continuingAppDisallowedToAlert(_ app: App)
    func didReceiveError(_ error: Error)
    func didReceiveNetworkConnectionError()
}

final class LaunchPresenter: LaunchPresenterProtocol {
    
    private var useCase: LaunchUseCaseProtocol!
    weak var output: LaunchPresenterOutputProtocol!
    
    init(useCase: LaunchUseCaseProtocol) {
        self.useCase = useCase
        self.useCase.output = self
    }
    
    func checkAppContinue() {
        useCase.checkAppContinue()
    }
}

extension LaunchPresenter: LaunchUseCaseOutputProtocol {
    func continuingAppAllowed() {
        output.continueAppLaunching()
    }
    
    func continuingAppDisallowed(_ app: App) {
        output.continuingAppDisallowedToAlert(app)
    }
    
    func didReceiveError(_ error: Error) {
        output.didReceiveError(error)
    }
    
    func didReceiveNetworkConnectionError() {
        output.didReceiveNetworkConnectionError()
    }
}
