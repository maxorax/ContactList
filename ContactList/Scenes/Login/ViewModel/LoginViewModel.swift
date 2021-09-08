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
    
    func transform(input: Input) {
        input.signInTrigger
            .flatMapLatest({ [weak self] _ -> Driver<Int16> in
                guard let self = self else { return Driver.empty() }
                
                return self.signInUseCase
                    .signIn(vc: input.vc)
                    .asDriver(onErrorJustReturn: 401)
            })
            .flatMapLatest({ [weak self] _ -> Driver<Domain.TokenContainer?> in
                guard let self = self else { return Driver.empty() }
                
                return self.signInUseCase
                    .getAccessToken()
                    .asDriverOnErrorJustComplete()
            })
            .flatMapLatest({ [weak self] token -> Driver<Void> in
                guard let self = self else { return Driver.empty() }
                
                guard let accessToken = token else {
                    return Driver.just(())
                }
                
                return self.accessUseCase
                    .storeToken(container: accessToken)
                    .asDriverOnErrorJustComplete()
            })
            .drive(onNext:{ _ in
                self.router.openContactModule()
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
}
