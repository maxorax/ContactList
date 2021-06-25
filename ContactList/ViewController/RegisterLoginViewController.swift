//
//  ViewController.swift
//  ContactList
//
//  Created by Maxorax on 22.06.2021.
//

import UIKit
import GoogleSignIn

class RegisterLoginViewController: UIViewController, GIDSignInDelegate{
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
         
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let contactVC = ContactViewController(nibName: "ContactViewController", bundle: nil)
        contactVC.modalPresentationStyle = .fullScreen
        appDelegate.window?.rootViewController = contactVC
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
    }
    
}
