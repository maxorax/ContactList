import UIKit
import GoogleSignIn
import RxSwift
import RxCocoa
import RxViewController

class LoginViewController: UIViewController {
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel: LoginViewModel!
    let disposeBag = DisposeBag()

    init(_ viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        //viewModel.presentingViewController(vc: self)
    }
    
    private func bindViewModel() {
        let signInTrigger = self.rx.viewWillAppear.asDriver().mapToVoid()
        let input = LoginViewModel.Input( signInTrigger: signInTrigger, vc: self, disposeBag: disposeBag)
        viewModel.transform(input: input)
    }
}



