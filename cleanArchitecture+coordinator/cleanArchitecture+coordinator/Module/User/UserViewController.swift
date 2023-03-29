import UIKit

protocol UserViewControllerTransitionDelegate: AnyObject {
    func showGetUserErrorDialog()
}

final class UserViewViewController: UIViewController {
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    private var presenter: UserPresenter!
    
    weak var transitionDelegate: UserViewControllerTransitionDelegate?
    
    func inject(presenter: UserPresenter) {
        self.presenter = presenter
        presenter.output = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
    }
}

extension UserViewViewController {
    private func setupData() {
        presenter.getUser()
    }
}

extension UserViewViewController: UserPresenterOutputProtocol {
    func didReceiveUser(_ user: User) {
        descriptionLabel.text = user.description ?? "NONE"
    }
    
    func didReceiveError(_ error: Error) {
    }
    
    func didReceiveNetworkConnectionError() {
    }
}
