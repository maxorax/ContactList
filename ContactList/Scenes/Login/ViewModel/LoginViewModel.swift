import Foundation
import UIKit.UIViewController

class LoginViewModel: LoginViewModelProtocol {
    
    var isSignInSuccess: Dynamic<Bool>!
    private let gIDSignInManager: GIDSignInManager = GIDSignInManager.shared
    private let router: LoginRouter.Routes
    
    init(container: Container) {
        router = container.router
        isSignInSuccess = Dynamic(false)
        gIDSignInManager.delegate = self
    }
    
    func presentingViewController(vc: UIViewController) {
        gIDSignInManager.presentingViewController(vc: vc)
    }
    
    func signIn(isSuccess: Bool) {
        self.isSignInSuccess.value = isSuccess
    }
    
    func openContactViewController() { 
        router.openContactModule()
    }
}

extension LoginViewModel {
    struct Container{
        var router: LoginRouter
    }
}
