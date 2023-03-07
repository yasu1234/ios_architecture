import RxSwift
import UIKit

class UserViewController: UIViewController {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var userImageView: UIImageView!
    
    private let disposeBag = DisposeBag()
    private let viewModel = UserViewModel()
    
    private var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
    }
}

extension UserViewController {
    private func setupData() {
        setupBind()
    }
    
    private func setupBind() {
        viewModel.outputs.user
            .subscribe(onNext: { user in
                self.user = user
            }).disposed(by: disposeBag)
        
        // if you want to present/push viewController, use this
        viewModel.outputs.user
            .bind(to: Binder(self) { controller, user in
                self.user = user
            }).disposed(by: disposeBag)
        
        viewModel.outputs.userName
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.outputs.isShowProfileImage
            .bind(to: userImageView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.outputs.profileImage
            .bind(to: userImageView.rx.image)
            .disposed(by: disposeBag)
        
        setupInput()
    }
}

extension UserViewController {
    private func setupInput() {
        getUser()
    }
    
    private func getUser() {
        viewModel.inputs.getUser()
    }
}

extension UserViewController {
    func newInstance() -> UserViewController {
        let controller = UIStoryboard(
            name:"User",
            bundle: nil
        ).instantiateViewController(withIdentifier: String(describing: UserViewController.self)) as! UserViewController
        
        return controller
    }

    func storyboardName() -> String {
        return "User"
    }

    func identifer() -> String {
        return String(describing: UserViewController.self)
    }
}
