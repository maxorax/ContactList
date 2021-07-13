import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    var viewModel: LoginViewModelProtocol! 
    
    init(_ viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.isSignInSuccess.bind {
            [weak self] signInIsSuccess in
            guard signInIsSuccess else { return }
            
            self?.viewModel.openContactViewController()
        }
        
        viewModel.presentingViewController(vc: self)
    }
}

