import Foundation

public struct EmailAddress: Codable{
    public let value: String
    
    public init(value: String){
        self.value = value
    }
}
