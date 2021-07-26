import Foundation

public protocol AccessUseCaseProvider {
    
    func makeSignInUseCase() -> AccessUseCase
    
}
