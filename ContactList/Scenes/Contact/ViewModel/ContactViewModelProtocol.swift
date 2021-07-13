import Foundation

protocol ContactViewModelProtocol {
    var contactDataCellArray: Dynamic<[ContactDataCell]>! { get }

    func getContacts()
    
    func signOut()
    
    func openSelectedCells(contactDataCell: ContactDataCell)
    
    func openLoginController()
}
