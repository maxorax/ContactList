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
    
    func openContactViewController() { 
        router.openContactModule()
    }
    
    func transform(input: Input) {
        _ = input.signInTrigger
            .flatMapLatest({ [weak self] _ -> Driver<Bool> in
                guard let self = self else { return Driver.empty() }
                
                return self.signInUseCase
                    .signIn(vc: input.vc)
                    .asDriver(onErrorJustReturn: false)
                    
            })
            .flatMapLatest({ [weak self] _ -> Driver<Domain.TokenContainer> in
                guard let self = self else { return Driver.empty() }
                
                return self.signInUseCase.getAccessToken()
                .asDriverOnErrorJustComplete()
                    
            })
            .flatMapLatest({ [weak self] value -> Driver<Void> in
                guard let self = self else { return Driver.empty() }
                
                return self.accessUseCase.storeToken(container:  value).asDriverOnErrorJustComplete()
            })
            .drive(onNext:{ _ in
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
