//
//  AppDelegate.swift
//  ContactList
//
//  Created by Maxorax on 22.06.2021.
//

import UIKit
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GIDSignIn.sharedInstance().clientID = "276109197611-ue1ounudsot2j7efbrvi56s7l23hncon.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        print(GIDSignIn.sharedInstance()?.currentUser?.profile.email ?? "nil")
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = GIDSignIn.sharedInstance()?.currentUser == nil ? RegisterLoginViewController() : ContactViewController()
        self.window?.makeKeyAndVisible()
        return true
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
        let contactVC = ContactViewController()
        //contactVC.modalPresentationStyle = .fullScreen
        self.window?.rootViewController = contactVC
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
    }


}

