import UIKit

class NotConnectionModule {
    let viewController: NotConnectionViewController
    
    init(transition: Transition?) {
        let router = NotConnectionRouter()
        let viewModelContainer = NotConnectionViewModel.Container(router: router)
        let viewModel = NotConnectionViewModel(container: viewModelContainer)
        let viewController = NotConnectionViewController(viewModel)
        router.viewController = viewController
        router.openTransition = transition
        self.viewController = viewController
    }
}
