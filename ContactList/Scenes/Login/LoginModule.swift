import UIKit
import SignInPlatform

class LoginModule {
    let viewController: LoginViewController

    init( transition: Transition?) {
        let router = LoginRouter()
        let signInUseCase = SignInUseCaseProvider.shared.makeSignInUseCase()
        let viewModelContainer = LoginViewModel.Container(
            router: router,
            signInUseCase: signInUseCase
        )
        let viewModel = LoginViewModel(container: viewModelContainer)
        let viewController = LoginViewController(viewModel)
        router.viewController = viewController
        router.openTransition = transition
        self.viewController = viewController
    }
}
