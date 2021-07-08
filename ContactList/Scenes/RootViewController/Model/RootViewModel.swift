import Foundation

class RootViewModel: RootViewModelProtocol {
    
    var signInIsSuccess: Dynamic<Bool>!
    var gIDSignInManager: GIDSignInManager = GIDSignInManager.shared

    
    init() {
        signInIsSuccess = Dynamic(false)
        gIDSignInManager.delegate = self
    }
    
    func signIn(isSuccess: Bool) {
        self.signInIsSuccess.value = isSuccess
    }
    
    func restore() {
        gIDSignInManager.restore()
    }
}
