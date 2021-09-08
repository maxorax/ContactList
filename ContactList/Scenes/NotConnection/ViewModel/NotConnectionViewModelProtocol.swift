import Foundation

protocol NotConnectionViewModelProtocol {
    associatedtype Input
    
    func transform(input: Input)
}
