import Foundation
import RxCocoa
import RxSwift
import Domain

class RootViewModel: RootViewModelProtocol {
    
    private let signInUseCase: Domain.SignInUseCase
    private let accessUseCase: Domain.AccessUseCase

    private let router: RootRouter.Routes
    private let errorTracker: ErrorTracker = ErrorTracker()
    let retryTask = PublishSubject<Void>()
    var closeNotConnection: () -> Void = {}
    

    init(container: Container) {
        router = container.router
        signInUseCase = container.signInUseCase
        accessUseCase = container.accessUseCase
    }
    
    func transform(input: Input) {
        var statusCode: Int16 = 0
        var errorCount = 0
        let trigger = Driver.merge(
            input.viewTrigger,
            retryTask.asDriverOnErrorJustComplete()
        )
            trigger.flatMapLatest { [weak self] _ -> Driver<Int16> in
                guard let self = self else { return Driver.empty() }
                
                return self.signInUseCase.restore()
                    .trackError(self.errorTracker)
                    .asDriverOnErrorJustComplete()
            }
            .flatMap { [weak self] value -> Driver<Domain.TokenContainer?> in
                guard let self = self else { return Driver.empty() }
                
                statusCode = value
                guard value == 200 else {
                    return Driver.just(nil)
                }
                
                return self.signInUseCase.getAccessToken()
                    .trackError(self.errorTracker)
                    .asDriverOnErrorJustComplete()
            }
            .flatMap { [weak self] token in
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
                
                switch statusCode {
                case 200:
                    guard errorCount == 0 else {
                        self.closeNotConnection()
                        self.router.openContactModule()
                        return
                        }
                    
                    self.router.openContactModule()
                case 401:
                    guard errorCount == 0 else {
                        self.closeNotConnection()
                        self.router.openLoginModule()
                        return
                    }
                   
                    self.router.openLoginModule()
                default:
                    guard errorCount == 0 else { return }
                    
                    self.router.openNotConnectionModule(delegate: self)
                    errorCount = 1
                }
                
            })
            .disposed(by: input.disposeBag)
        
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
}

extension RootViewModel: NotConnectionDelegate {
    func retry(trigger: Driver<Void>,  disposeBag: DisposeBag ,closeNotConnectionModule: @escaping () -> Void) {
        self.closeNotConnection = closeNotConnectionModule
        trigger.drive(onNext: {
            self.retryTask.on(.next(()))
        }).disposed(by: disposeBag)
    }
}
