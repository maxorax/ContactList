import Foundation
import RxSwift
import RxCocoa
import Domain


class NotConnectionViewModel: NotConnectionViewModelProtocol {
    private let router: NotConnectionRouter.Routes
    private let delegate: NotConnectionDelegate
        
    init(container: Container) {
        router = container.router
        delegate = container.delegate
    }
    
    func transform(input: Input) {
        delegate.retry(
            trigger: input.retryTrigger,
            disposeBag: input.disposeBag,
            closeNotConnectionModule: { self.router.closeNotConnectionModule() }
        )
    }
}

extension NotConnectionViewModel {
    struct Container {
        let router: NotConnectionRouter
        let delegate: NotConnectionDelegate
    }
    struct Input {
        let retryTrigger: Driver<Void>
        var disposeBag: DisposeBag
    }
}
