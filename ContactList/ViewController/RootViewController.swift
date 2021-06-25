//
//  RootViewController.swift
//  ContactList
//
//  Created by Maxorax on 25.06.2021.
//

import UIKit
import GoogleSignIn

class RootViewController: UIViewController, GIDSignInDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        GIDSignIn.sharedInstance().clientID = "276109197611-ue1ounudsot2j7efbrvi56s7l23hncon.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        checkLoggedIsUser()

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
         
        showContactVC()
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
    }
    
    func checkLoggedIsUser(){
        guard let _ = GIDSignIn.sharedInstance()?.currentUser else {
            showRegisterLoginVC()
            return
        }
        showContactVC()
    }
    
    func showContactVC(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let contactVC = ContactViewController(nibName: "ContactViewController", bundle: nil)
        contactVC.modalPresentationStyle = .fullScreen
        appDelegate.window?.rootViewController = contactVC
        
    }
    
    func showRegisterLoginVC(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let registerLoginVC = RegisterLoginViewController(nibName: "RegisterLoginViewController", bundle: nil)
        registerLoginVC.modalPresentationStyle = .fullScreen
        appDelegate.window?.rootViewController = registerLoginVC
    }
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
