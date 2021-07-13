import UIKit

class ContactModule {
    let viewController: ContactViewController
    
    init (transition: Transition?) {
        let router = ContactRouter()
        let viewModelContainer = ContactViewModel.Container(
            router: router
        )
        let viewModel = ContactViewModel(container: viewModelContainer)
        let viewController = ContactViewController(viewModel)
        router.viewController = viewController
        router.openTransition = transition
        self.viewController = viewController
    }
}
