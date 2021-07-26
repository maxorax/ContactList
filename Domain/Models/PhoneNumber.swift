import Foundation

public struct PhoneNumber: Codable{
    public let value: String
    
    public init(value: String){
        self.value = value
    }
}
