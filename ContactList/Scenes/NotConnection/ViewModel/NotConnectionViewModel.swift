import Foundation

class NotConnectionViewModel: NotConnectionViewModelProtocol {
    private let router: NotConnectionRouter.Routes
    
    init(container: Container) {
        router = container.router
    }
    
    func openRootController() {
        router.openRootModule()
    }
}

extension NotConnectionViewModel {
    struct Container {
        let router: NotConnectionRouter
    }
}
