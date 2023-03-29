import Foundation

import Foundation

protocol UserPresenterProtocol: AnyObject {
    func getUser()
}

protocol UserPresenterOutputProtocol: AnyObject {
    func didReceiveUser(_ user: User)
    func didReceiveError(_ error: Error)
    func didReceiveNetworkConnectionError()
}

final class UserPresenter: UserPresenterProtocol {
    
    private var useCase: UserUseCaseProtocol!
    weak var output: UserPresenterOutputProtocol!
    
    init(useCase: UserUseCaseProtocol) {
        self.useCase = useCase
        self.useCase.output = self
    }
    
    func getUser() {
        useCase.getUser()
    }
}

extension UserPresenter: UserUseCaseOutputProtocol {
    func didReceiveUser(_ user: User) {
        output.didReceiveUser(user)
    }
    
    func didReceiveError(_ error: Error) {
        output.didReceiveError(error)
    }
    
    func didReceiveNetworkConnectionError() {
        output.didReceiveNetworkConnectionError()
    }
}
