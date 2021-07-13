import Foundation

protocol ContactRoute {
    func openContactModule()
}

extension ContactRoute where Self: RouterProtocol {
    func openContactModule() {
        let transition = PushTransition()
        let module = ContactModule(transition: transition)
        open(module.viewController, transition: transition)
    }
}
