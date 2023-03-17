import UIKit

final class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let rootViewController: UIViewController
    
    var launchCoordinator: LaunchCoordinator
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = .init()
        
        launchCoordinator = LaunchCoordinator(window: window)
    }
    
    func start() {
        window.rootViewController = rootViewController
        
        defer {
            window.makeKeyAndVisible()
        }
        
        launchCoordinator.start()
    }
}
