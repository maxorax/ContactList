import UIKit

class PushNavigationTransition: NSObject {
    weak var viewController: UIViewController?
}

// MARK: - Transition

extension PushNavigationTransition: Transition {

    func open(_ viewController: UIViewController) {
        self.viewController?.navigationController?.delegate = self
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }

    func close(_ viewController: UIViewController) {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UINavigationControllerDelegate

extension PushNavigationTransition: UINavigationControllerDelegate { }
