import Foundation
import UIKit.UIViewController
import RxSwift
import RxCocoa

class LoginViewModel: LoginViewModelProtocol {
  
    private let gIDSignInManager: GIDSignInManager = GIDSignInManager.shared
    private let router: LoginRouter.Routes
    
    init(container: Container) {
        router = container.router
    }
    
    func presentingViewController(vc: UIViewController) {
        gIDSignInManager.presentingViewController(vc: vc)
    }
    
    func openContactViewController() { 
        router.openContactModule()
    }
    
    func transform(input: Input) {
        _ = input.signInTrigger
            .flatMapLatest({ _  in
                return self.gIDSignInManager
                    .signIn(vc: input.vc)
                    .asDriver(onErrorJustReturn: false)
            })
            .drive(onNext:{ value in
                guard value == true else {
                    return
                }
            
                self.openContactViewController()
            })
            .disposed(by: input.disposeBag)
    }
}

extension LoginViewModel {
    struct Container{
        var router: LoginRouter
    }
    struct Input {
        var signInTrigger: Driver<Void>
        var vc: UIViewController
        var disposeBag: DisposeBag
    }
    struct Output {
        var isSignInSuccess: Driver<Bool>
    }
}
