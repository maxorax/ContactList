import Foundation
import RxSwift
import Domain

protocol ContactInfoViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    func getContact(people: Domain.People ) -> Single<Domain.People>
    
    @discardableResult func transform(input: Input) -> Output

}
