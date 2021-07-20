import Foundation

protocol RootViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    func openConctactController()
    
    func openLoginController()
    
    func transform(input: Input) -> Output
}
