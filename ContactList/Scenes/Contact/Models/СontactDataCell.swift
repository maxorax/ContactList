import Foundation

struct ContactDataCell {
    var name: String 
    var photoData: Data?
    var email: String
    var phoneNumber: String
    
    init() {
        name = ""
        photoData = nil
        email = ""
        phoneNumber = ""
    }
}
