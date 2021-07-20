import Foundation
import RxSwift
protocol ContactInfoViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    func getContact(name: String, phoneNumber: String?, email: String, photoUrl: String?) -> Single<People>
    
    @discardableResult func transform(input: Input) -> Output

}
