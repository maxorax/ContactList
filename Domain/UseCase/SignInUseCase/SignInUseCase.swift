import Foundation
import RxSwift
import GoogleSignIn

public protocol SignInUseCase: GIDSignInDelegate {
    var statusCode: PublishSubject<Int16> { get }
    
    func signIn(vc: UIViewController) -> Single<Int16>
    func restore() -> Single<Int16>
    func getAccessToken() -> Single<Domain.TokenContainer?>
    func signOut()
}
