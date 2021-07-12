import UIKit

class LoginModule {
    
    let router: LoginRouter
    let viewController: LoginViewController

    private let viewModel: LoginViewModel
    
    init( transition: Transition?) {
        let router = LoginRouter()
        
        let viewModelContainer = LoginViewModel.Container(
            router: router
        )
        let viewModel = LoginViewModel(container: viewModelContainer)
        let viewController = LoginViewController(viewModel)
        
        self.router = router
        self.viewController = viewController
        self.viewModel = viewModel
    }
}
