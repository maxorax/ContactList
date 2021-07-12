import UIKit

class PushTransition: NSObject {
    
    weak var viewController: UIViewController?
}

// MARK: - Transition

extension PushTransition: Transition {

    func open(_ viewController: UIViewController) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let navController = UINavigationController()
        appDelegate.window?.rootViewController = navController
        navController.pushViewController(viewController, animated: false)
    }

    func close(_ viewController: UIViewController) {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}

