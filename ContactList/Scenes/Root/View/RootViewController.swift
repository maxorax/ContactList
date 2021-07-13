import UIKit

class RootViewController: UIViewController {
    
    var viewModel: RootViewModelProtocol!
    
    init(_ viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.isSignInSuccess.bind {
            [weak self] signInSuccess in
            guard signInSuccess else {
                self?.viewModel.openLoginController()
                return
            }
            
            self?.viewModel.openConctactController()
        }

        viewModel.restore()
    }
}

