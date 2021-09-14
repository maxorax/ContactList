import Foundation

public struct Peoples: Codable{
    public let people: [People]
    
    public init(people: [People]) {
        self.people = people
    }
}

