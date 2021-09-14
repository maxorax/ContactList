import Foundation

public protocol SignInUseCaseProvider {
    func makeSignInUseCase() -> SignInUseCase
}
