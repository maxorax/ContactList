import Foundation
import UIKit.UIViewController
import RxSwift
import RxCocoa
import Domain
import SignInPlatform

class LoginViewModel: LoginViewModelProtocol {
  
    private let signInUseCase: Domain.SignInUseCase
    private let router: LoginRouter.Routes
    
    init(container: Container) {
        router = container.router
        signInUseCase = container.signInUseCase
    }
    
    func presentingViewController(vc: UIViewController) {
        signInUseCase.presentingViewController(vc: vc)
    }
    
    func openContactViewController() { 
        router.openContactModule()
    }
    
    func transform(input: Input) {
        _ = input.signInTrigger
            .flatMapLatest({ _  in
                return self.signInUseCase
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
        let router: LoginRouter
        let signInUseCase: Domain.SignInUseCase
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
