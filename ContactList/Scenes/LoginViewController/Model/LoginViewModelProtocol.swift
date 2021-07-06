//
//  LoginViewModelProtocol.swift
//  ContactList
//
//  Created by Maxorax on 05.07.2021.
//

import Foundation
import UIKit.UIViewController

protocol LoginViewModelProtocol: GIDSignInManagerDelegate {
    
    var signInIsSuccess: Dynamic<Bool>! { get }
    
    func presentingViewController(vc: UIViewController)

}


