import UIKit
import SignInPlatform
import StoragePlatform

class LoginModule {
    let viewController: LoginViewController

    init( transition: Transition?) {
        let router = LoginRouter()
        let signInUseCase = SignInUseCaseProvider.shared.makeSignInUseCase()
        let accessUseCase = AccessUseCaseProvider.shared.makeSignInUseCase()
        let viewModelContainer = LoginViewModel.Container(
            router: router,
            signInUseCase: signInUseCase,
            accessUseCase: accessUseCase
        )
        let viewModel = LoginViewModel(container: viewModelContainer)
        let viewController = LoginViewController(viewModel)
        router.viewController = viewController
        router.openTransition = transition
        self.viewController = viewController
    }
}
