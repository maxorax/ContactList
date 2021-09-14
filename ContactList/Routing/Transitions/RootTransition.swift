import UIKit

class RootTransition: NSObject {
    
    weak var viewController: UIViewController?
}

// MARK: - Transition

extension RootTransition: Transition {

    func open(_ viewController: UIViewController) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        appDelegate.window?.rootViewController = viewController
    }

    func close(_ viewController: UIViewController) {}
}
