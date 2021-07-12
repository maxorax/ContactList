import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    var loginViewModel: LoginViewModelProtocol! 
    
    init(_ viewModel: LoginViewModel) {
        loginViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginViewModel.isSignInSuccess.bind{
            [weak self] signInIsSuccess in
            guard signInIsSuccess else { return }
            
            self?.showContactVC()
        }
        loginViewModel.presentingViewController(vc: self)
    }
}

//MARK: -Routing

extension LoginViewController {
    func showContactVC() {
        loginViewModel.openContactViewController()
    }
}

