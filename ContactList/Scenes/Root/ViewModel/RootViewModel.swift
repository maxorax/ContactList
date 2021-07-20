import Foundation
import RxCocoa
import RxSwift

class RootViewModel: RootViewModelProtocol {
    
    private let gIDSignInManager: GIDSignInManager = GIDSignInManager.shared
    private let router: RootRouter.Routes
    private let errorTracker: ErrorTracker = ErrorTracker()

    init(container: Container) {
        router = container.router
    }
    
    func openConctactController() {
        router.openContactModule()
    }
    
    func openLoginController() {
        router.openLoginModule()
    }
    
    func transform(input: Input) -> Output {
        _ = input.viewTrigger.flatMapLatest { _ in
            return self.gIDSignInManager.restore()
                .trackError(self.errorTracker)
                .asDriverOnErrorJustComplete()
        }.drive(onNext:{ value in
            value ? self.openConctactController() : self.openLoginController()
        }).disposed(by: input.disposeBag)
        return Output(errorTracker: errorTracker)
    }
}

extension RootViewModel {
    struct Container {
        var router: RootRouter
    }
    struct Input {
        var viewTrigger: Driver<Void> = .just(())
        var disposeBag: DisposeBag
    }
    struct Output{
        var errorTracker: ErrorTracker
    }
}
