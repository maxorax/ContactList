import Foundation
import RxSwift

protocol NotConnectionRoute{
    func openNotConnectionModule(delegate: RootViewModel)
    func closeNotConnectionModule()
}

extension NotConnectionRoute where Self: RouterProtocol {
    func openNotConnectionModule(delegate: RootViewModel) {
        let transition = ModalTransition()
        let module = NotConnectionModule(transition: transition, delegate: delegate)
        open(module.viewController, transition: transition)
    }
    
    func closeNotConnectionModule() {
        close()
    }
}
