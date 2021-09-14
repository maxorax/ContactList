import UIKit
import StoragePlatform
import SignInPlatform

class RootModule {
    let viewController: RootViewController
    
    init( transition: Transition?) {
        let router = RootRouter()
        let accessUseCase = AccessUseCaseProvider.shared.makeSignInUseCase()
        let signInUseCase = SignInUseCaseProvider.shared.makeSignInUseCase()
        let viewModelContainer = RootViewModel.Container(
            router: router,
            signInUseCase: signInUseCase,
            accessUseCase: accessUseCase
        )
        let viewModel = RootViewModel(container: viewModelContainer)
        let viewController = RootViewController(viewModel)
        router.viewController = viewController
        router.openTransition = transition
        self.viewController = viewController
    }
}
