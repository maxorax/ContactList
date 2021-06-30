//
//  Contacs.swift
//  ContactList
//
//  Created by Maxorax on 25.06.2021.
//

import Foundation

struct People: Codable {
    let names: [Name]
    let phoneNumbers: [PhoneNumber]?
    let photos: [Photo]?
    let emailAddresses: [EmailAdress]
    
}
struct Name: Codable {
    let displayName: String
}

struct Photo: Codable{
    let url: String
}
struct EmailAdress: Codable{
    let value: String
}

struct PhoneNumber: Codable{
    let value: String
}

struct Peoples: Codable{
    let people: [People]
}

