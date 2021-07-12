import Foundation

struct People: Codable {
    let names: [Name]
    let phoneNumbers: [PhoneNumber]?
    let photos: [Photo]?
    let emailAddresses: [EmailAddress]
}
