import UIKit

class PushNavigationTransition: NSObject {
    var completionHandler: (() -> Void)?
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

extension PushNavigationTransition: UINavigationControllerDelegate {
//    func navigationController(
//        _ navigationController: UINavigationController,
//        didShow viewController: UIViewController,
//        animated: Bool) {
//        completionHandler?()
//    }

}
