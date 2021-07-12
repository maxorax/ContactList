import Foundation

protocol RootViewModelProtocol: GIDSignInManagerDelegate {
    
    var isSignInSuccess: Dynamic<Bool>! { get }
    
    func restore()
    
    func openConctactController()
    
    func openLoginController()
}
