import Foundation

public struct People: Codable {
    public let names: [Name]
    public let phoneNumbers: [PhoneNumber]?
    public let photos: [Photo]?
    public let emailAddresses: [EmailAddress]
    public init(names: [Name], phoneNumbers: [PhoneNumber]?, photos: [Photo]?, emailAddresses: [EmailAddress]) {
        self.names = names
        self.phoneNumbers = phoneNumbers
        self.photos = photos
        self.emailAddresses = emailAddresses
    }
}
