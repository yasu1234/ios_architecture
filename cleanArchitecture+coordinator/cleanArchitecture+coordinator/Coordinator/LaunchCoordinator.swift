import UIKit

class LaunchCoordinator: Coordinator {
    private let window: UIWindow
    private var launchViewController: LaunchViewController?
    
    private var launchUseCase: LaunchUseCase!
    
    private var userCoordinator: UserCoordinator?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewController = UIStoryboard(name: "Launch", bundle: nil).instantiateInitialViewController() as! LaunchViewController
        viewController.transitionDelegate = self
        
        launchViewController = viewController
        
        let useCase = LaunchUseCase()
        self.launchUseCase = useCase
        
        let checkAppGateway = CheckAppGateway()
        useCase.appUpdateGateway = checkAppGateway
        
        checkAppGateway.appUpdateRequest = AppsRequestFactory.createAppsRequestStub()
        
        viewController.inject(presenter: LaunchPresenter(useCase: useCase))
        
        window.rootViewController = viewController
    }
}

extension LaunchCoordinator: LaunchViewControllerTransitionDelegate {
    func canAppLaunch() {
        let coordinator = UserCoordinator(window: window)
        userCoordinator = coordinator
        
        coordinator.start()
    }
}
