//
//  ContactViewController.swift
//  ContactList
//
//  Created by Maxorax on 24.06.2021.
//

import UIKit
import GoogleSignIn

class ContactViewController: UIViewController {
    

    @IBOutlet weak var logoutButton: UIButton!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton(button: logoutButton)
    }
    
    func setupButton(button: UIButton){
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
    }

    @IBAction func signOut(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        let registerLoginVC = RegisterLoginViewController()
        registerLoginVC.modalPresentationStyle = .fullScreen
        self.present(registerLoginVC, animated: false, completion: nil)
    }
   

}
