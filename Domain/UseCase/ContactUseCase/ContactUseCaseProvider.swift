import Foundation

public protocol ContactUseCaseProvider {
    func makeContactUseCase() -> ContactUseCase
}
