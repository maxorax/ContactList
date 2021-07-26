import Foundation
import Domain

public class SignInUseCaseProvider:  Domain.SignInUseCaseProvider{
    public static let shared = SignInUseCaseProvider()
    
    let signInUseCase: Domain.SignInUseCase
    
    public init() {
        signInUseCase = SignInUseCase()
    }
    
    public func makeSignInUseCase() -> Domain.SignInUseCase {
        return signInUseCase
    }
}
