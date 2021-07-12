import UIKit

class ContactModule {
    
    let router: ContactRouter
    let viewController: ContactViewController

    private let viewModel: ContactViewModel
    
    init (transition: Transition?) {
        let router = ContactRouter()
        
        let viewModelContainer = ContactViewModel.Container(
            router: router
        )
        let viewModel = ContactViewModel(container: viewModelContainer)
        let viewController = ContactViewController(viewModel)
        
        self.router = router
        self.viewController = viewController
        self.viewModel = viewModel
    }
}
