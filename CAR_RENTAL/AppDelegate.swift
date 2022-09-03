//
//  AppDelegate.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 31.07.2022.
//

import UIKit
import FirebaseCore
//Push Notifications :
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self
        //Coordinator Integration --------------------------------- START

        let navVC = UINavigationController()
        let coordinator = MainCoordinator()
        coordinator.navigationController = navVC
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navVC
        
        window.makeKeyAndVisible()
        self.window = window
        
        coordinator.start()
        
        //Coordinator Integration --------------------------------- END
        
        
        
        //Push Notificaions 3 :
        
        registerForPushNotifications()
        
        
        // Check if launched from notification
        let notificationOption = launchOptions?[.remoteNotification]

        // 1
        if
          let notification = notificationOption as? [String: AnyObject],
          let aps = notification["aps"] as? [String: AnyObject] {
          // 2
            NotifData.makeNotifItem(aps)
            print("nAsılsıun")
          // 3
          //(window?.rootViewController as? UITabBarController)?.selectedIndex = 1
        }
        
        
        return true
    }
    
    //Push Notificaions 2:
    func registerForPushNotifications() { 
      //1
      UNUserNotificationCenter.current()
        //2
        .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
          //3
          print("Permission granted: \(granted)")
        }
    }
    
    
    ////Push Notificaions 3:
    func getNotificationSettings() { UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data ) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error ) {
        print("Failed to register: \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
      fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void ) {
      guard let aps = userInfo["aps"] as? [String: AnyObject] else {
        completionHandler(.failed)
        return
      }
        NotifData.makeNotifItem(aps)
        print("Merhabaaaaaaaaaaaaa")

        completionHandler(.newData)
    }
 
    

}

