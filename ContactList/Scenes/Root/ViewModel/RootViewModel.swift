import Foundation
import RxCocoa
import RxSwift
import Domain

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
        var isSucccess = false
        _ = input.viewTrigger
            .flatMapLatest { [weak self] _ -> Driver<Bool> in
                guard let self = self else { return Driver.empty() }
                
                return self.signInUseCase.restore()
                    .trackError(self.errorTracker)
                    .asDriverOnErrorJustComplete()
            }
            .flatMapLatest { [weak self] value -> Driver<TokenContainer> in
                guard
                    let self = self
                else { return Driver.empty() }
                
                isSucccess = value
                guard value else {
                    return Driver.empty()
                }
                
                return self.signInUseCase.getAccessToken()
                .asDriverOnErrorJustComplete()
               
            }
            .flatMapLatest { [weak self] token in
                guard let self = self else { return Driver.empty() }
                
                 return self.accessUseCase.storeToken(container:  token).asDriverOnErrorJustComplete()
            }
            .drive(onNext:{ [weak self] ()  in
                guard let self = self else { return }
        
                guard isSucccess else {
                    self.openLoginController()
                    return
                    }
        
                self.openConctactController()
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
