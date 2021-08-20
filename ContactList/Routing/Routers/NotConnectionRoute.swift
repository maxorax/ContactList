import Foundation

protocol NotConnectionRoute{
    func openNotConnectionModule()
}

extension NotConnectionRoute where Self: RouterProtocol {
    func openNotConnectionModule() {
        let transition = RootTransition()
        let module = NotConnectionModule(transition: transition)
        open(module.viewController, transition: transition)
    }
}
