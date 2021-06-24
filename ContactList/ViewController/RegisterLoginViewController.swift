//
//  ViewController.swift
//  ContactList
//
//  Created by Maxorax on 22.06.2021.
//

import UIKit
import GoogleSignIn

class RegisterLoginViewController: UIViewController {
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
}
