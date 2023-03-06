import RxSwift
import RxCocoa

protocol UserViewModelInputs: AnyObject {
    func getUser()
}

protocol UserViewModelOutputs: AnyObject {
    var user: BehaviorRelay<User> { get }
}

protocol UserViewModelType: AnyObject {
    var inputs: UserViewModelInputs { get }
    var outputs: UserViewModelOutputs { get }
}

class UserViewModel: UserViewModelType,
                     UserViewModelInputs,
                     UserViewModelOutputs {
    var inputs: UserViewModelInputs { return self }
    var outputs: UserViewModelOutputs { return self }
    
    var user = BehaviorRelay<User>(value: User())
    
    private var userRequest: UserRequest?
    
    private let disposeBag = DisposeBag()
    
    func getUser() {
        if userRequest != nil {
            return
        }
        
        let request = UserRequest()
        userRequest = request
                
        request.get()
            .flatMap { response -> Observable<User> in
                if response != nil {
                    return Observable<User>.just(response)
                } else {
                    return Observable<User>.just(response)
                }
            }.subscribe(
                onNext: { value in
                    self.user.accept(value)
                },
                onError: { error in
                    print(error)
                },
                onCompleted: nil,
                onDisposed: nil)
            .disposed(by: disposeBag)
    }
}
