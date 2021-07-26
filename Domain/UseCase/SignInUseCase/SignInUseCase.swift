import Foundation
import RxSwift
import GoogleSignIn

public protocol SignInUseCase: GIDSignInDelegate {
    var isSuccess: PublishSubject<Bool> { get }
    
    func signIn(vc: UIViewController) -> Single<Bool>
    func restore() -> Single<Bool>
    func getAccessToken() -> String?
    func presentingViewController(vc: UIViewController)
    func signOut()
}