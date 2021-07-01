//
//  People.swift
//  ContactList
//
//  Created by Maxorax on 01.07.2021.
//

import Foundation

struct People: Codable {
    let names: [Name]
    let phoneNumbers: [PhoneNumber]?
    let photos: [Photo]?
    let emailAddresses: [EmailAddress]
}
