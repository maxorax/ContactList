//
//  ContactViewModelProtocol.swift
//  ContactList
//
//  Created by Maxorax on 01.07.2021.
//

import Foundation

protocol ContactViewModelProtocol {
    var contactDataCellArray: Dynamic<[ContactDataCell]>! { get }

    func getContacts()
    
    func signOut()
        
}
