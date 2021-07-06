//
//  ContactInfoViewModelProtocol.swift
//  ContactList
//
//  Created by Maxorax on 06.07.2021.
//

import Foundation

protocol ContactInfoViewModelProtocol {
    var name: Dynamic<String>! { get }
    var phoneNumber: Dynamic<String>! { get }
    var email: Dynamic<String>! { get }
    var photoData: Dynamic<Data>! { get }
    
    func getContact(contact: ContactDataCell)
}