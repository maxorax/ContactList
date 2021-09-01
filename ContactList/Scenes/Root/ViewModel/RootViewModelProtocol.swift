import Foundation

protocol RootViewModelProtocol {
    associatedtype Input
    
    func transform(input: Input)
}
