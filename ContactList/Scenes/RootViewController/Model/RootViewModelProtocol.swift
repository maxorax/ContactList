import Foundation

protocol RootViewModelProtocol: GIDSignInManagerDelegate {
    
    var signInIsSuccess: Dynamic<Bool>! { get }
    
    func restore()
}
