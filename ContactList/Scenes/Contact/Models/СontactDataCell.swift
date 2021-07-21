import Foundation

struct ContactDataCell {
    var name: String 
    var photoUrl: String?
    var email: String
    var phoneNumber: String
    
    init() {
        name = ""
        photoUrl = nil
        email = ""
        phoneNumber = ""
    }
}
