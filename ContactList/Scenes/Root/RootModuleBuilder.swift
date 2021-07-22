import StoragePlatform
import SignInPlatform

final class RootModuleBuilder {
    
    static func module() -> RootViewController {
        let router = RootRouter()
        let signInUseCase = SignInUseCaseProvider.shared.makeSignInUseCase()
        let accessUseCase = AccessUseCaseProvider.shared.makeSignInUseCase()
        let viewModel = RootViewModel(
            container: RootViewModel.Container(
                router: router,
                signInUseCase: signInUseCase,
                accessUseCase: accessUseCase
            )
        )
        let viewController = RootViewController(viewModel)
        router.viewController = viewController
        return viewController
    }
}
