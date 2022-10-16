import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // インスタンス変数の初期化時に、他のインスタンス変数の値を使用することはできない
    // lazyプロパティにすることで遅延して初期化するかviewDidload()で行えばエラーは発生しない
    private var viewModel = LoginViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupUI()
    }
}

extension LoginViewController {
    private func setupData() {
        setupBind()
    }
    
    private func setupBind() {
        // nilの場合にはviewModelに渡さない
//        idTextField.rx.text.orEmpty
//            .bind(to: viewModel.inputs.currentId)
//            .disposed(by: disposeBag)
        
        // nilの場合には空文字をviewModelに渡す
        idTextField.rx.text.map { $0 ?? "" }
            .bind(to: viewModel.inputs.currentId)
            .disposed(by: disposeBag)
        
//        passwordTextField.rx.text.orEmpty
//            .bind(to: viewModel.inputs.currentPassword)
//            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.map { $0 ?? "" }
            .bind(to: viewModel.inputs.currentPassword)
            .disposed(by: disposeBag)
        
        viewModel.outputs.loginButtonEnbled
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}

extension LoginViewController {
    private func setupUI() {
        setupButton()
    }
    
    private func setupButton() {
        loginButton.rx.tap
            .bind(to: viewModel.inputs.loginButtonTapped)
            .disposed(by: disposeBag)
    }
}

extension LoginViewController {
//
//    @objc func updateValidationText() {
////        guard let text = notification.object as? String else { return }
//        let alert: UIAlertController = UIAlertController(title: "ログインエラー",
//                                                         message: text,
//                                                         preferredStyle:  UIAlertController.Style.alert)
//
//        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
//            (action: UIAlertAction!) -> Void in
//        })
//
//        alert.addAction(defaultAction)
//
//        present(alert, animated: true, completion: nil)
//    }
}
