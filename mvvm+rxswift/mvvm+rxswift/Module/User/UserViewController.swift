import RxSwift
import UIKit

class UserViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
