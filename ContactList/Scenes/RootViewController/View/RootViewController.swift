import UIKit


class RootViewController: UIViewController {
    
    var rootViewModel: RootViewModelProtocol! = RootViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootViewModel.signInIsSuccess.bind{
            [weak self] signInSuccess in
            guard signInSuccess else {
                self?.showRegisterLoginVC()
                return
            }
            
            self?.showContactVC()
        }
        rootViewModel.restore()
    }
}

//MARK: -Routing

extension RootViewController {
    func showContactVC() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let navController = UINavigationController()
        appDelegate.window?.rootViewController = navController
        navController.pushViewController(ContactViewController(), animated: false)
        
    }
    
    func showRegisterLoginVC() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        appDelegate.window?.rootViewController = LoginViewController()
    }
}
