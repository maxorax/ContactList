final class RootModuleBuilder {
    
    static func module() -> RootViewController {
        let router = RootRouter()
        let viewModel = RootViewModel(container: RootViewModel.Container(router: router))
        let viewController = RootViewController(viewModel)
        router.viewController = viewController
        return viewController
    }
}
