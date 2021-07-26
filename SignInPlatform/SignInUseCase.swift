import Foundation
import GoogleSignIn
import RxCocoa
import RxSwift
import Domain

public class SignInUseCase: NSObject, Domain.SignInUseCase {
    
    public var isSuccess: PublishSubject<Bool> = PublishSubject()
    
    public override init() {
        super.init()

        GIDSignIn.sharedInstance().clientID = Domain.Constants.clientIDAPI
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.scopes = Domain.Constants.scopesAPI
    }
    
    public func signIn(vc: UIViewController) -> Single<Bool> {
        GIDSignIn.sharedInstance()?.presentingViewController = vc
        return isSuccess.take(1).asSingle()
    }
    
    public func restore() -> Single<Bool> {
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        return isSuccess.take(1).asSingle()
    }
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            if (error as NSError)
                .code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                DispatchQueue.main.async {
                    self.isSuccess.onNext(false)
                }
            } else {
                self.isSuccess.onError(error)
            }
            return
        }
        DispatchQueue.main.async {
            self.isSuccess.onNext(true)
        }
    }
    
    public func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
    }
    
    public func getAccessToken() -> Single<Domain.TokenContainer> {
            
            return Single.create{
                single in
               
                do{
                    guard let accessToken =  GIDSignIn.sharedInstance()?.currentUser.authentication.accessToken else {
                        throw NSError()
                    }
                    
                    single(.success(Domain.TokenContainer(token: accessToken)))

                } catch let error{
                    single(.failure(error))
                }
                
                return Disposables.create ()
            }
    }
    
    public func signOut() {
        GIDSignIn.sharedInstance()?.signOut()
    }
}
