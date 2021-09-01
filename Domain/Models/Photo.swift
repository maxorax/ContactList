import Foundation

public struct Photo: Codable{
    public let url: String
    
    public init(url: String) {
        self.url = url
    }
}
