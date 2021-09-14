import Foundation
import RxSwift

public protocol AccessUseCase {
     func obtainToken() -> Single<TokenContainer?>
     func storeToken(container: TokenContainer) -> Single<Void>
}
