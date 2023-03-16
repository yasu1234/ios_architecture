import Alamofire
import AlamofireImage
import RxSwift
import RxCocoa

protocol UserViewModelInputs: AnyObject {
    func getUser()
}

protocol UserViewModelOutputs: AnyObject {
    var user: BehaviorRelay<User> { get }
    var userName: BehaviorRelay<String> { get }
    var isShowProfileImage: BehaviorRelay<Bool> { get }
    var profileImage: BehaviorRelay<UIImage> { get }
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
    var userName = BehaviorRelay<String>(value: "")
    var isShowProfileImage = BehaviorRelay<Bool>(value: false)
    var profileImage = BehaviorRelay<UIImage>(value: UIImage())
    
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
                    self.userName.accept(value.name ?? "")
                    self.isShowProfileImage.accept(value.imageUrl == nil || value.imageUrl!.isEmpty)
                    
                    if let url = value.imageUrl {
                        AF.request(url, method: .get).responseImage { response in
                            if let image = response.value {
                                self.profileImage.accept(image)
                            }
                        }
                    }
                },
                onError: { error in
                    switch error {
                    case APIError.error(let message, let type):
                        print(message)
                    default:
                        print("Error")
                    }
                },
                onCompleted: nil,
                onDisposed: nil)
            .disposed(by: disposeBag)
    }
}
