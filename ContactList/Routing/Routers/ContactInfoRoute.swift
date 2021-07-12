import Foundation

protocol ContactInfoRoute {
    func openContactInfoModule(contactDataCell: ContactDataCell)
}

extension ContactInfoRoute where Self: RouterProtocol {
    func openContactInfoModule(contactDataCell: ContactDataCell) {
        let transition = PushNavigationTransition()
        let module = ContactInfoModule(contactDataCell: contactDataCell, transition: transition)
        module.router.openTransition = transition
        open(module.viewController, transition: transition)
    }
}

