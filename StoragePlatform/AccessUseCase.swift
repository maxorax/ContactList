import Foundation
import Domain
import RxSwift

public class AccessUseCase: Domain.AccessUseCase {
    
    public func obtainToken() -> Single<TokenContainer?> {
        return Single.create{ single in
            guard let token = UserDefaults.standard.string(forKey: "Key") else {
                single(.success(nil))
                return Disposables.create ()
            }
            
            single(.success(TokenContainer(token: token )))
            return Disposables.create()
        }
    }
    
    public func storeToken(container: TokenContainer) -> Single<Void>{
        UserDefaults.standard.set(container.token, forKey: "Key")
        return Single.just(())
        
    }
    
}
