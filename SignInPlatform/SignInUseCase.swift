import Foundation
import GoogleSignIn
import RxCocoa
import RxSwift
import Domain

public class SignInUseCase: NSObject, Domain.SignInUseCase {

    public var statusCode: PublishSubject<Int16> = PublishSubject()
    
    public override init() {
        super.init()

        GIDSignIn.sharedInstance().clientID = Domain.Constants.clientIDAPI
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.scopes = Domain.Constants.scopesAPI
    }
    
    public func signIn(vc: UIViewController) -> Single<Int16> {
        GIDSignIn.sharedInstance()?.presentingViewController = vc
        return statusCode.take(1).asSingle()
    }
    
    public func restore() -> Single<Int16> {
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        return statusCode.take(1).asSingle()
    }
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            if (error as NSError)
                .code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                DispatchQueue.main.async {
                    self.statusCode.onNext(401)
                }
            } else {
                self.statusCode.onNext(499)
            }
            return
        }
        DispatchQueue.main.async {
            self.statusCode.onNext(200)
        }
    }
    
    public func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
    }
    
    public func getAccessToken() -> Single<Domain.TokenContainer?> {
            return Single.create{
                single in
               
                do{
                    guard
                        let accessToken =  GIDSignIn.sharedInstance()?.currentUser.authentication.accessToken
                    else {
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
