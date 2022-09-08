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
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        application.registerForRemoteNotifications()
        
        // Local and Firebase Messagin, both need this:
        UNUserNotificationCenter.current().delegate = self
        
        
        //Coordinator Integration --------------------------------- START
        
        let navVC = UINavigationController()
        let coordinator = MainCoordinator(navigationController: navVC)
        coordinator.start()
        
        if AuthService.insance.loggedIn == true {
            coordinator.navOccured(with: .mainVC)
        }
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navVC
        
        window.makeKeyAndVisible()
        self.window = window
        

        
        //Coordinator Integration --------------------------------- END
        
        
        
        //Push Notificaions 3 :
        registerForPushNotifications()
        
        
        // Check if launched from notification
        if let notificationOption = launchOptions?[.remoteNotification] {
            if let notification = notificationOption as? [String: AnyObject],
               let aps = notification["aps"] as? [String: AnyObject] {
                coordinator.navOccured(with: .notifVC)
                print("aps")
            }
            
        }
        

        
        return true
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, _ in
            guard let token = token else {
                return
            }
            print ("Firebase Messaging Token :  \(token)")
        }
    }
    
    // Request for user Auth : (for both local and firebase)
    func registerForPushNotifications() { UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
        
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
        
        // Print full message.
        //print(userInfo)
        
        completionHandler(.newData)
    }
    
    
    
}

