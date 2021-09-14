import UIKit

class ModalTransition: NSObject {
    weak var viewController: UIViewController?
}

// MARK: - Transition

extension ModalTransition: Transition {
    func open(_ viewController: UIViewController) {
        viewController.modalPresentationStyle = .overFullScreen
        self.viewController?.show(viewController, sender: self)
    }

    func close(_ viewController: UIViewController) {
        self.viewController?.dismiss(animated: false, completion: nil)
    }
}
