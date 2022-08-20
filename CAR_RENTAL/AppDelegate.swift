//
//  AppDelegate.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 31.07.2022.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if AuthService.insance.loggedIn == true {
            
            window?.rootViewController = UINavigationController(rootViewController: MainVC())
            window?.makeKeyAndVisible()
            window?.backgroundColor = .white
            
        } else {
            
            let loginVC = LoginVC()
            window?.rootViewController = loginVC
            
            window?.makeKeyAndVisible()
            window?.backgroundColor = .white
        }
        
        return true
    }
    
}

