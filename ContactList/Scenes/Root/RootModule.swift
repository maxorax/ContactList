import UIKit

class RootModule {
    let viewController: RootViewController
    private let viewModel: RootViewModel
    
    init( transition: Transition?) {
        let router = RootRouter()
        let viewModelContainer = RootViewModel.Container(router: router)
        let viewModel = RootViewModel(container: viewModelContainer)
        let viewController = RootViewController(viewModel)
        router.viewController = viewController
        router.openTransition = transition
        self.viewController = viewController
        self.viewModel = viewModel        
    }
}
