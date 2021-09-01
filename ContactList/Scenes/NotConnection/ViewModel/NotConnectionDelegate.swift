import Foundation
import RxCocoa
import RxSwift

protocol NotConnectionDelegate {
    
    func retry(trigger: Driver<Void>, disposeBag: DisposeBag ,closeNotConnectionModule: @escaping () -> Void)
    
}
