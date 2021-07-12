import UIKit

class LoginTransition: NSObject {
    
    weak var viewController: UIViewController?
}

// MARK: - Transition

extension LoginTransition: Transition {

    func open(_ viewController: UIViewController) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.window?.rootViewController = viewController
    }

    func close(_ viewController: UIViewController) {}
}
