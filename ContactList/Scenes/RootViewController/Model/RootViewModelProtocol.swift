//
//  RootViewModelProtocol.swift
//  ContactList
//
//  Created by Maxorax on 06.07.2021.
//

import Foundation

protocol RootViewModelProtocol: GIDSignInManagerDelegate {
    
    var signInIsSuccess: Dynamic<Bool>! { get }
    
    func restore()
}
