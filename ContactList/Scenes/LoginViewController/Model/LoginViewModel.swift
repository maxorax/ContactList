import Foundation
import UIKit.UIViewController

class LoginViewModel: LoginViewModelProtocol {
    
    var signInIsSuccess: Dynamic<Bool>!
    var gIDSignInManager: GIDSignInManager = GIDSignInManager.shared
    private let router: LoginRouter.Routes
    
    init(container: Container) {
        self.router = container.router
        self.signInIsSuccess = Dynamic(false)
        gIDSignInManager.delegate = self
    }
    
    func presentingViewController(vc: UIViewController) {
        gIDSignInManager.presentingViewController(vc: vc)
    }
    
    func signIn(isSuccess: Bool) {
        self.signInIsSuccess.value = isSuccess
    }
    
    func openContactViewController(){
        router.openContactModule()
    }
    
}

extension LoginViewModel {
    struct Container{
        var router: LoginRouter
    }
}
