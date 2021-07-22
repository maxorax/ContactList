import Foundation
import RxSwift
import Domain

protocol ContactInfoViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    func getContact(name: Domain.Name, phoneNumber: Domain.PhoneNumber?, email: Domain.EmailAddress, photoUrl: Domain.Photo? ) -> Single<Domain.People>
    
    @discardableResult func transform(input: Input) -> Output

}
