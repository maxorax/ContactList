import UIKit
import Domain
import NetworkPlatform

class ContactInfoModule {
    let viewController: ContactInfoViewController
    
    init(people: Domain.People, transition: Transition?) {
        let router = ContactInfoRouter()
        let contactUseCase = ContactUseCaseProvider.shared.makeContactUseCase()
        let viewModelContainer = ContactInfoViewModel.Container(
            router: router,
            people: people,
            contactUseCase: contactUseCase
        )
        let viewModel = ContactInfoViewModel(container: viewModelContainer)
        let viewController = ContactInfoViewController(viewModel)
        router.viewController = viewController
        router.openTransition = transition
        self.viewController = viewController
    }
}
