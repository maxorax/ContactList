import Foundation

class RootViewModel: RootViewModelProtocol {
    
    var isSignInSuccess: Dynamic<Bool>!
    private let gIDSignInManager: GIDSignInManager = GIDSignInManager.shared
    private let router: RootRouter.Routes

    init(container: Container) {
        router = container.router
        isSignInSuccess = Dynamic(false)
        gIDSignInManager.delegate = self
    }
    
    func signIn(isSuccess: Bool) {
        self.isSignInSuccess.value = isSuccess
    }
    
    func restore() {
        gIDSignInManager.restore()
    }
    
    func openConctactController() {
        router.openContactModule()
    }
    
    func openLoginController() {
        router.openLoginModule()
    }
    
}

extension RootViewModel {
    struct Container {
        var router: RootRouter
    }
}
