import UIKit

class NotConnectionModule {
    let viewController: NotConnectionViewController
    let viewModel: NotConnectionViewModel
    
    init(transition: Transition?, delegate: RootViewModel) {
        let router = NotConnectionRouter()
        let viewModelContainer = NotConnectionViewModel.Container(
            router: router,
            delegate: delegate
        )
        let viewModel = NotConnectionViewModel(container: viewModelContainer)
        let viewController = NotConnectionViewController(viewModel)
        router.viewController = viewController
        router.openTransition = transition
        self.viewController = viewController
        self.viewModel = viewModel
    }
}
