import UIKit

class LoginModule {
    let viewController: LoginViewController

    private let viewModel: LoginViewModel
    
    init( transition: Transition?) {
        let router = LoginRouter()
        let viewModelContainer = LoginViewModel.Container(
            router: router
        )
        let viewModel = LoginViewModel(container: viewModelContainer)
        let viewController = LoginViewController(viewModel)
        router.viewController = viewController
        router.openTransition = transition
        self.viewController = viewController
        self.viewModel = viewModel
    }
}
