import Foundation

struct ContactViewModel: ContactViewModelProtocol {
    
    var contactDataCellArray: Dynamic<[ContactDataCell]>!
    
    private let gIDSignInManager: GIDSignInManager = GIDSignInManager.shared
    private let networkManager: NetworkManager = NetworkManager()
    private let router: ContactRouter.Routes
    
    init(container: Container) {
        router = container.router
        contactDataCellArray = Dynamic([])
        getContacts()
    }
    
    func signOut() {
        gIDSignInManager.signOut()
    }
    
    func getContacts() {
        guard
            let accessToken = gIDSignInManager.getAccessToken()
        else { return }
        
        networkManager.getContacs(accessToken: accessToken) { (peoples) in
            for index in 0..<peoples.count {
                contactDataCellArray.value.append(ContactDataCell())
                self.contactDataCellArray.value[index].name =
                    peoples[index].names[0].displayName
                self.contactDataCellArray.value[index].email =
                  peoples[index].emailAddresses[0].value
                self.contactDataCellArray.value[index].phoneNumber =
                    peoples[index].phoneNumbers?[0].value ??
                    "No number"
                if let photoUrl = peoples[index].photos?[0].url {
                    networkManager.getContactPhoto(photoUrl: photoUrl) { (data) in
                        self.contactDataCellArray.value[index].photoData = data
                    }
                }
            }
        }
    }
    
    func openSelectedCells(contactDataCell: ContactDataCell) {
        router.openContactInfoModule(contactDataCell: contactDataCell)
    }
   
    func openLoginController() {
        router.openLoginModule()
    }
}

extension ContactViewModel {
    struct Container {
        var router: ContactRouter
    }
}
