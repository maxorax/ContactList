import Foundation
import RxCocoa
import RxSwift
import Domain
import SignInPlatform

class RootViewModel: RootViewModelProtocol {
    
    private let signInUseCase: Domain.SignInUseCase
    private let accessUseCase: Domain.AccessUseCase

    private let router: RootRouter.Routes
    private let errorTracker: ErrorTracker = ErrorTracker()

    init(container: Container) {
        router = container.router
        signInUseCase = container.signInUseCase
        accessUseCase = container.accessUseCase
    }
    
    func openConctactController() {
        router.openContactModule()
    }
    
    func openLoginController() {
        router.openLoginModule()
    }
    
    func transform(input: Input) -> Output {
        _ = input.viewTrigger
            .flatMapLatest { _ in
                return self.signInUseCase.restore()
                    .trackError(self.errorTracker)
                    .asDriverOnErrorJustComplete()
            }
            .drive(onNext:{ value in
                guard value else {
                    self.openLoginController()
                    return
                }
                
                self.accessUseCase.storeToken(container: Domain.TokenContainer (token:  self.signInUseCase.getAccessToken()!))
                self.openConctactController()
                //value ? self.openConctactController() : self.openLoginController()
            })
            .disposed(by: input.disposeBag)
        return Output(errorTracker: errorTracker)
    }
}

extension RootViewModel {
    struct Container {
        let router: RootRouter
        let signInUseCase: Domain.SignInUseCase
        let accessUseCase: Domain.AccessUseCase
    }
    struct Input {
        var viewTrigger: Driver<Void> = .just(())
        var disposeBag: DisposeBag
    }
    struct Output{
        var errorTracker: ErrorTracker
    }
}
