import Foundation

protocol RootRoute{
    func openRootModule()
}

extension RootRoute where Self: RouterProtocol {
    func openRootModule() {
        let transition = RootTransition()
        let module = RootModule(transition: transition)
        open(module.viewController, transition: transition)
    }
}
