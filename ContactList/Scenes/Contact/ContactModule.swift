import UIKit
import StoragePlatform
import SignInPlatform
import NetworkPlatform

class ContactModule {
    let viewController: ContactViewController
    
    init (transition: Transition?) {
        let router = ContactRouter()
        let signInUseCase = SignInUseCaseProvider.shared.makeSignInUseCase()
        let accessUseCase = AccessUseCaseProvider.shared.makeSignInUseCase()
        let contactUseCase = ContactUseCaseProvider.shared.makeContactUseCase()
        let viewModelContainer = ContactViewModel.Container(
            router: router,
            signInUseCase: signInUseCase,
            contactUseCase: contactUseCase,
            accessUseCase: accessUseCase
        )
        let viewModel = ContactViewModel(container: viewModelContainer)
        let viewController = ContactViewController(viewModel)
        router.viewController = viewController
        router.openTransition = transition
        self.viewController = viewController
    }
}
