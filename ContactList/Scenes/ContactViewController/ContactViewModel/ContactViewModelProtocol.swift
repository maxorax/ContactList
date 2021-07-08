import Foundation

protocol ContactViewModelProtocol {
    var contactDataCellArray: Dynamic<[ContactDataCell]>! { get }

    func getContacts()
    
    func signOut()
}
