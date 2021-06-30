//
//  RootViewController.swift
//  ContactList
//
//  Created by Maxorax on 25.06.2021.
//

import UIKit
import GoogleSignIn
import Alamofire

class RootViewController: UIViewController, GIDSignInDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        GIDSignIn.sharedInstance().clientID = "276109197611-ue1ounudsot2j7efbrvi56s7l23hncon.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.scopes = [
                "https://www.google.com/m8/feeds",
                "https://www.googleapis.com/auth/user.phonenumbers.read",
                "https://www.googleapis.com/auth/user.organization.read",
                "https://www.googleapis.com/auth/userinfo.profile",
                "https://www.googleapis.com/auth/userinfo.email",
                "https://www.googleapis.com/auth/directory.readonly"]
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        

    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                showRegisterLoginVC()
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        showContactVC()
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
    }
    
    
    func showContactVC(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let navController = UINavigationController()
        appDelegate.window?.rootViewController = navController
        navController.pushViewController(ContactViewController(), animated: false)
        
    }
    
    func showRegisterLoginVC(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        appDelegate.window?.rootViewController = RegisterLoginViewController()
    }
    
}
