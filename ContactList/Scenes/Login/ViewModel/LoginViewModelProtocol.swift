import Foundation
import UIKit.UIViewController

protocol LoginViewModelProtocol: GIDSignInManagerDelegate {
    
    var isSignInSuccess: Dynamic<Bool>! { get }
    
    func presentingViewController(vc: UIViewController)
    
    func openContactViewController()

}


