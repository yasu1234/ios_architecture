import Foundation
import RxCocoa
import RxSwift

protocol LoginViewModelType {
  var inputs: LoginViewModelInputs { get }
  var outputs: LoginViewModelOutputs { get }
}

protocol LoginViewModelInputs {
    var currentId: PublishRelay<String> { get }
    var currentPassword: PublishRelay<String> { get }
    var loginButtonTapped: PublishRelay<Void> { get }
}

protocol LoginViewModelOutputs {
    var loginButtonEnbled: BehaviorRelay<Bool> { get }
}

class LoginViewModel: LoginViewModelType,
                      LoginViewModelInputs,
                      LoginViewModelOutputs {
    var inputs: LoginViewModelInputs { return self }
    var outputs: LoginViewModelOutputs { return self }
    
    var currentId = PublishRelay<String>()
    var currentPassword = PublishRelay<String>()
    var loginButtonTapped = PublishRelay<Void>()

    var loginButtonEnbled = BehaviorRelay<Bool>(value: false)
    
    private let disposeBag = DisposeBag()
    
    init() {        
        // 初期でボタンをタップできないようにするためにBehaviorRelayを使用
        Observable.combineLatest(currentId.asObservable(),
                                 currentPassword.asObservable()) { id, password in
            return !id.isEmpty &&
            !password.isEmpty &&
            id.count > 3 &&
            password.count > 3
        }.subscribe(onNext: { isValid in
            self.loginButtonEnbled.accept(isValid)
        }).disposed(by: disposeBag)

        loginButtonTapped
            .subscribe(onNext: { [weak self] _ in
                self?.login()
            })
            .disposed(by: disposeBag)
    }
    
    func login() {
        
    }
}
