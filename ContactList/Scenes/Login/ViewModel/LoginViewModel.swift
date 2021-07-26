import Foundation
import UIKit.UIViewController
import RxSwift
import RxCocoa
import Domain

class LoginViewModel: LoginViewModelProtocol {
  
    private let signInUseCase: Domain.SignInUseCase
    private let accessUseCase: Domain.AccessUseCase

    private let router: LoginRouter.Routes
    
    init(container: Container) {
        router = container.router
        signInUseCase = container.signInUseCase
        accessUseCase = container.accessUseCase
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
                self.accessUseCase.storeToken(container: Domain.TokenContainer (token:  self.signInUseCase.getAccessToken()!))
                self.openContactViewController()
            })
            .disposed(by: input.disposeBag)
    }
}

extension LoginViewModel {
    struct Container{
        let router: LoginRouter
        let signInUseCase: Domain.SignInUseCase
        let accessUseCase: Domain.AccessUseCase
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
