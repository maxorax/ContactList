import UIKit

class RootViewController: UIViewController {
    
    var rootViewModel: RootViewModelProtocol!
    
    init(_ viewModel: RootViewModel) {
        rootViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootViewModel.isSignInSuccess.bind{
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
        rootViewModel.openConctactController()
    }
    
    func showRegisterLoginVC() {
        rootViewModel.openLoginController()
    }
}
