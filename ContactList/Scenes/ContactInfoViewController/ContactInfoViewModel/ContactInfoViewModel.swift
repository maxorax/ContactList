import Foundation

class ContactInfoViewModel: ContactInfoViewModelProtocol {
    
    var name: Dynamic<String>!
    var phoneNumber: Dynamic<String>!
    var email: Dynamic<String>!
    var photoData: Dynamic<Data>!
    
    init() {
        name = Dynamic("")
        phoneNumber = Dynamic("")
        email = Dynamic("")
        photoData = Dynamic(Data())
    }
    
    func getContact(contact: ContactDataCell) {
        self.name.value = contact.name
        self.email.value = contact.email
        self.phoneNumber.value = contact.phoneNumber
        guard let photoData = contact.photoData else { return }
        
        self.photoData.value = photoData
    }
    
}
