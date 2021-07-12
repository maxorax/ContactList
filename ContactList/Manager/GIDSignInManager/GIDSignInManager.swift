import Foundation
import GoogleSignIn

class GIDSignInManager: NSObject, GIDSignInDelegate {
    
    static let shared = GIDSignInManager()
    
    public weak var delegate: GIDSignInManagerDelegate?     
    
    private override init() {
        super.init()
        
        GIDSignIn.sharedInstance().clientID = Constants.clientIDAPI
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.scopes = Constants.scopesAPI
    }
    
    func restore() {
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            if (error as NSError)
                .code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                delegate?.signIn(isSuccess: false)
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        delegate?.signIn(isSuccess: true)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
    }
    
    func getAccessToken() -> String? {
        guard let currentUser = GIDSignIn.sharedInstance()?.currentUser else { return nil }
        guard
            let accesToken = currentUser.authentication.accessToken
        else {
            return nil
        }
        return accesToken
    }
    
    func presentingViewController(vc: UIViewController) {
        GIDSignIn.sharedInstance()?.presentingViewController = vc
    }
    
    func signOut() {
        GIDSignIn.sharedInstance()?.signOut()
    }
    
}
