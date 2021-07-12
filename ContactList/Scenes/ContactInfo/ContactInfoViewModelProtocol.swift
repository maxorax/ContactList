import Foundation

protocol ContactInfoViewModelProtocol {
    var name: Dynamic<String>! { get }
    var phoneNumber: Dynamic<String>! { get }
    var email: Dynamic<String>! { get }
    var photoData: Dynamic<Data>! { get }
    var contactDataCell: ContactDataCell { get }
    
    func getContact()
}
