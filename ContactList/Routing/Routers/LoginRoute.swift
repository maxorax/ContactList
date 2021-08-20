import Foundation

protocol LoginRoute {
    func openLoginModule()
}

extension LoginRoute where Self: RouterProtocol {
    func openLoginModule() {
        let transition = RootTransition()
        let module = LoginModule(transition: transition)
        open(module.viewController, transition: transition)
    }
}
