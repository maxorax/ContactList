import Foundation
import Domain

public class AccessUseCaseProvider: Domain.AccessUseCaseProvider {
    
    public static let shared = AccessUseCaseProvider()
    let accessUseCase: Domain.AccessUseCase
    
    public init() {
        accessUseCase = AccessUseCase()
    }
    
    public func makeSignInUseCase() -> Domain.AccessUseCase {
        return accessUseCase
    }
    
    
}
