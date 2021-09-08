import Foundation
import Domain

public class ContactUseCaseProvider: Domain.ContactUseCaseProvider {
   
    public static let shared = ContactUseCaseProvider()
    let contactUseCase: Domain.ContactUseCase
    
    public init() {
        contactUseCase = ContactUseCase()
    }
    
    public func makeContactUseCase() -> Domain.ContactUseCase {
        return contactUseCase
    }
    
}
