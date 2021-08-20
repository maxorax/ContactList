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
    
    func openNotConnectionController() {
        router.openNotConnectionModule()
    }
    
    func transform(input: Input) -> Output {
        var isSuccess = false
        _ = input.viewTrigger
            .flatMapLatest { [weak self] _ -> Driver<Bool> in
                guard let self = self else { return Driver.empty() }
                
                return self.signInUseCase.restore()
                    .trackError(self.errorTracker)
                    .asDriverOnErrorJustComplete()
            }
            .flatMapLatest { [weak self] value -> Driver<Domain.TokenContainer?> in
                guard let self = self else { return Driver.empty() }
                
                isSuccess = value
                guard value else {
                    return Driver.just(nil)
                }
                
                return self.signInUseCase.getAccessToken()
                    .trackError(self.errorTracker)
                    .asDriverOnErrorJustComplete()
            }
            .flatMapLatest { [weak self] token in
                guard let self = self else { return Driver.empty() }
                
                guard let accesstoken = token else {
                    return Driver.just(())
                }
                
                return self.accessUseCase.storeToken(container:  accesstoken)
                    .trackError(self.errorTracker)
                    .asDriverOnErrorJustComplete()
            }
            .drive(onNext:{ [weak self] ()  in
                guard let self = self else { return }
                
                guard isSuccess else {
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
