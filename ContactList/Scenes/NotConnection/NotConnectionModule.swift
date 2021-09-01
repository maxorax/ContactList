import UIKit
import StoragePlatform
import SignInPlatform
import RxSwift

class NotConnectionModule {
    let viewController: NotConnectionViewController
    let viewModel: NotConnectionViewModel
    
    init(transition: Transition?, delegate: RootViewModel) {
        let router = NotConnectionRouter()
        let accessUseCase = AccessUseCaseProvider.shared.makeSignInUseCase()
        let signInUseCase = SignInUseCaseProvider.shared.makeSignInUseCase()
        let viewModelContainer = NotConnectionViewModel.Container(
            router: router,
            signInUseCase: signInUseCase,
            accessUseCase: accessUseCase,
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
