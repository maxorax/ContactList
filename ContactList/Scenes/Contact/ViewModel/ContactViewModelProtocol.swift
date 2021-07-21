import Foundation
import RxSwift

protocol ContactViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    func signOut()
    
    func openSelectedCells(people: People)
    
    func openLoginController()
    
    @discardableResult func transform(input: Input) -> Output
}


