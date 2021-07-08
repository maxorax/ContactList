import Foundation
import UIKit.UIViewController

class LoginViewModel: LoginViewModelProtocol {
    
    var signInIsSuccess: Dynamic<Bool>!
    var gIDSignInManager: GIDSignInManager = GIDSignInManager.shared
    
    init() {
        self.signInIsSuccess = Dynamic(false)
        gIDSignInManager.delegate = self
    }
    
    func presentingViewController(vc: UIViewController) {
        gIDSignInManager.presentingViewController(vc: vc)
    }
    
    func signIn(isSuccess: Bool) {
        self.signInIsSuccess.value = isSuccess
    }
    
}
