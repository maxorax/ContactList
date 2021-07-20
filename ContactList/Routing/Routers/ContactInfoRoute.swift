import Foundation

protocol ContactInfoRoute {
    func openContactInfoModule(people: People)
}

extension ContactInfoRoute where Self: RouterProtocol {
    func openContactInfoModule(people: People) {
        let transition = PushNavigationTransition()
        let module = ContactInfoModule(people: people, transition: transition)
        open(module.viewController, transition: transition)
    }
}

