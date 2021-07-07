import Foundation
import UIKit.UIViewController

protocol LoginViewModelProtocol: GIDSignInManagerDelegate {
    
    var signInIsSuccess: Dynamic<Bool>! { get }
    
    func presentingViewController(vc: UIViewController)

}


