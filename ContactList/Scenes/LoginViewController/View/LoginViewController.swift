import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    var loginViewModel: LoginViewModelProtocol! {
        didSet{
            loginViewModel.signInIsSuccess.bind{
                [weak self] signInIsSuccess in
                guard signInIsSuccess else { return }
                
                self?.showContactVC()
            }
        }
    }
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginViewModel = LoginViewModel()
        loginViewModel.presentingViewController(vc: self)
    }
}

//MARK: -Routing

extension LoginViewController {
    func showContactVC() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        let navController = UINavigationController()
        appDelegate.window?.rootViewController = navController
        navController.pushViewController(
            ContactViewController(),
            animated: false
        )
    }
}

