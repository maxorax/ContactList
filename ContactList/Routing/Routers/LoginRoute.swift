import Foundation

protocol LoginRoute {
    func openLoginModule()
}

extension LoginRoute where Self: RouterProtocol {
    func openLoginModule() {
        let transition = LoginTransition()
        let module = LoginModule(transition: transition)
        module.router.openTransition = transition
        open(module.viewController, transition: transition)
    }
}
