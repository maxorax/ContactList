import Foundation
import GoogleSignIn
import RxSwift
import RxCocoa

class GIDSignInManager: NSObject, GIDSignInDelegate {
    
    static let shared = GIDSignInManager()
    
    var isSuccess: PublishSubject<Bool> = PublishSubject()
    
    private override init() {
        super.init()

        GIDSignIn.sharedInstance().clientID = Constants.clientIDAPI
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.scopes = Constants.scopesAPI
    }
    
    func signIn(vc: UIViewController) -> Single<Bool> {
        GIDSignIn.sharedInstance()?.presentingViewController = vc
        return isSuccess.take(1).asSingle()
    }
    
    func restore() -> Single<Bool> {
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        return isSuccess.take(1).asSingle()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
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
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
    }
    
    func getAccessToken() -> String? {
        guard
            let accesToken = GIDSignIn.sharedInstance()?.currentUser.authentication.accessToken
        else { return nil }
        
        return accesToken
    }
    
    func presentingViewController(vc: UIViewController) {
        GIDSignIn.sharedInstance()?.presentingViewController = vc
    }
    
    func signOut() {
        GIDSignIn.sharedInstance()?.signOut()
    }
    
}
