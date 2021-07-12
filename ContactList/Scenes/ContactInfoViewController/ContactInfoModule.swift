import UIKit

class ContactInfoModule {
    
    let router: ContactInfoRouter
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

        self.router = router
        self.viewController = viewController
        self.viewModel = viewModel
    }
}
