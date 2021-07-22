import Foundation
import Domain

protocol ContactInfoRoute {
    func openContactInfoModule(people: Domain.People)
}

extension ContactInfoRoute where Self: RouterProtocol {
    func openContactInfoModule(people: Domain.People) {
        let transition = PushNavigationTransition()
        let module = ContactInfoModule(people: people, transition: transition)
        open(module.viewController, transition: transition)
    }
}

