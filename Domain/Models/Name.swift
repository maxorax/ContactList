import Foundation

public struct Name: Codable {
    public let displayName: String
    
    public init(displayName: String){
        self.displayName = displayName
    }
}
