//
//  AppDelegate.swift
//  ContactList
//
//  Created by Maxorax on 22.06.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        print("width = \(UIScreen.main.bounds.width)")
        print("height = \(UIScreen.main.bounds.height)")

        // Override point for customization after application launch.
       // let nib: UINib = UINib(nibName: "ViewController", bundle: nil)
        let vc = ViewController()
        
        self.window?.rootViewController = vc
        UIView.transition(
            with: self.window!,
                    duration: 0,
                    options: .transitionCrossDissolve,
                    animations: nil,
                    completion: nil
                )
        

        self.window?.makeKeyAndVisible()
        return true
    }

    


}

