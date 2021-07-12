import UIKit

class Router<GVC>: RouterProtocol, Closable where GVC: UIViewController {
    typealias GenericController = GVC

    weak var viewController: GenericController?
    var openTransition: Transition?
    
    func open(_ viewController: UIViewController, transition: Transition) {
        transition.viewController = self.viewController
        transition.open(viewController)
    }

    func close() {
        guard let openTransition = openTransition else {
            assertionFailure("You should specify an open transition in order to close a module.")
            return
        }
        
        guard let viewController = viewController else {
            assertionFailure("Nothing to close.")
            return
        }
        
        openTransition.close(viewController)
    }
}
