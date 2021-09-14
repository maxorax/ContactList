import Foundation
import RxSwift
import Domain

protocol ContactViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    func signOut()
    
    func openSelectedCells(people: Domain.People)
    
    func openLoginController()
    
    @discardableResult func transform(input: Input) -> Output
}


