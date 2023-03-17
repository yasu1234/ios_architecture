import UIKit

protocol LaunchViewControllerTransitionDelegate: AnyObject {
    func canAppLaunch()
}

final class LaunchViewController: UIViewController {
    
    private var presenter: LaunchPresenter!
    
    weak var transitionDelegate: LaunchViewControllerTransitionDelegate?
    
    private var url: String?
    private var urgentLevel: Int?
    
    func inject(presenter: LaunchPresenter) {
        self.presenter = presenter
        presenter.output = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
    }
}

extension LaunchViewController {
    private func setupData() {
        presenter.checkAppContinue()
    }
}

extension LaunchViewController: LaunchPresenterOutputProtocol {
    func didReceiveError(_ error: Error) {
    }
    
    func didReceiveNetworkConnectionError() {
    }
    
    func continueAppLaunching() {
        transitionDelegate?.canAppLaunch()
    }
    
    func continuingAppDisallowedToAlert(_ appUpdate: App) {
    }
}
