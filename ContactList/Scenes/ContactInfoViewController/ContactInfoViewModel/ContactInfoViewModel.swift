import Foundation

class ContactInfoViewModel: ContactInfoViewModelProtocol {
    
    var name: Dynamic<String>!
    var phoneNumber: Dynamic<String>!
    var email: Dynamic<String>!
    var photoData: Dynamic<Data>!
    
    private let router: ContactInfoRouter.Routes
    
    init(container: Container) {
        self.router = container.router
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

extension ContactInfoViewModel {
    struct Container {
        let router: ContactInfoRouter
        let contactDataCell: ContactDataCell
    }
}

//extension ContactInfoViewModel {
//    struct Container {
//        var router: ContactInfoRouter
//    }
//}
