import UIKit

class ContactInfoModule {
    let viewController: ContactInfoViewController
    private let viewModel: ContactInfoViewModel
    
    init(contactDataCell: ContactDataCell, transition: Transition?) {
        let router = ContactInfoRouter()
        let viewModelContainer = ContactInfoViewModel.Container(
            router: router,
            contactDataCell: contactDataCell
        )
        let viewModel = ContactInfoViewModel(container: viewModelContainer)
        let viewController = ContactInfoViewController(viewModel)
        router.viewController = viewController
        router.openTransition = transition
        self.viewController = viewController
        self.viewModel = viewModel
    }
}
