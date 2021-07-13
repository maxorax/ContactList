import Foundation

class ContactInfoViewModel: ContactInfoViewModelProtocol {
    
    var name: Dynamic<String>!
    var phoneNumber: Dynamic<String>!
    var email: Dynamic<String>!
    var photoData: Dynamic<Data>!
    var contactDataCell: ContactDataCell
    
    private let router: ContactInfoRouter.Routes
    
    init(container: Container) {
        router = container.router
        name = Dynamic("")
        phoneNumber = Dynamic("")
        email = Dynamic("")
        photoData = Dynamic(Data())
        self.contactDataCell = container.contactDataCell
        
    }
    
    func getContact() {
        self.name.value = contactDataCell.name
        self.email.value = contactDataCell.email
        self.phoneNumber.value = contactDataCell.phoneNumber
        guard let photoData = contactDataCell.photoData else { return }
        
        self.photoData.value = photoData
    }
    
}

extension ContactInfoViewModel {
    struct Container {
        let router: ContactInfoRouter
        let contactDataCell: ContactDataCell
    }
}

