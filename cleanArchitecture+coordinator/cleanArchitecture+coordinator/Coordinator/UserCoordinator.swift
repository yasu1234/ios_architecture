//
//  UserCoordinator.swift
//  cleanArchitecture+coordinator
//
//  Created by 神代泰宏 on 2023/03/26.
//

import UIKit

class UserCoordinator: Coordinator {
    private let window: UIWindow
    
    private var loginIntroductionNavigationController: UINavigationController?
    private var webNavigationController: UINavigationController?
    
    private var userViewController: UserViewViewController?
    
    private var userCoordinator: UserCoordinator?
    
    private var userUseCase: UserUseCase!
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        setupUserViewController()
        
//        window.setRootViewControllerAnimated(
//            userViewController!,
//            completion: nil
//        )
        if let controller = userViewController {
            window.rootViewController = controller
        }
    }
    
    private func setupUserViewController() {
        let userViewController = UIStoryboard(name: "User", bundle: nil).instantiateInitialViewController() as! UserViewViewController
//        userViewController.transitionDelegate = self
        self.userViewController = userViewController
        
        let useCase = UserUseCase()
        self.userUseCase = useCase
        
        let userGateway = UserGateway()
        userGateway.usersRequest = UsersRequestFactory.createUsersRequest()
        useCase.userGateway = userGateway
        
        userViewController.inject(presenter: UserPresenter(useCase: useCase))
    }

//    private func setupMainNavigatonController() {
//        let mainNavigationController = MainNavigationViewController(menuViewController: sideMenuViewController!, contentViewController: mapViewController!)
//        self.mainNavigationController = mainNavigationController
//    }
}
