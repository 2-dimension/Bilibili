//
//  AppDelegate.swift
//  Bilibili
//
//  Created by YaeSakura on 2017/3/3.
//  Copyright © 2017年 2-Dimension. All rights reserved.
//

import UIKit
import CoreSpotlight
import UserNotifications
import URLNavigator
import Sakura
import BilibiliAPI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    // Mark: Life Cycle
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setup()
        //test()
        
//        UIApplication.shared.applicationIconBadgeNumber = 1
//        let badgeNumber = UIApplication.shared.applicationIconBadgeNumber//.value(forKey: "applicationIconBadgeNumber")
//        print("badgeNumber: \(badgeNumber)")
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
//        UIApplication.shared.applicationIconBadgeNumber = 5
        self.setApplicationBadgeNumber(badgeNumber: 1)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    
    //MARK: Misc
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        // URLNavigator Handler
        if Navigator.default.open(url.absoluteString) {
            return true
        }
        
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        
        // Spotlight
        if #available(iOS 9.0, *) {
            if userActivity.activityType == CSSearchableItemActionType {
                
            }
        }
        
        // Universal links
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb  {
            let _ = userActivity.webpageURL
            
        }
        
        return true
    }
    
    
    //MARK: Notification
    
    // Before iOS 10
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        
    }
    
    // Before iOS 10
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable : Any], completionHandler: @escaping () -> Void) {
        
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        if notification.request.trigger is UNPushNotificationTrigger {
            // Background
            print(userInfo)
        } else {
            // Foreground
        }
        
        completionHandler([.alert, .badge, .sound])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if response.notification.request.trigger is UNPushNotificationTrigger {
            // Background
            print(userInfo)
        } else {
            // Foreground
        }
    }
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    
    //MARK: Encapsulation
    
    private func test() {
        BilibiliAPI.getVideoInfo(aid: 12104863, success: { (response) in
            if  var result = response.result,
                let data = try? JSONEncoder().encode(result) {
                result.title = "dsaa"
                let desc = String(data: data, encoding: .utf8)
                print(desc ?? "NIL")
            }
        }, failure: { (response) in
            print("Request failed. \(response)")
        })
    }
    
    private func setup() {
        
        //Misc
        registerNotification()
        
        // Setup exception handler.
        NSSetUncaughtExceptionHandler { (exception) in
            print("Exception: \(exception.name)")
            print("Reason: \(exception.reason ?? "")")
            print("Call Stack:")
            for symbol in exception.callStackSymbols {
                print(symbol)
            }
        }
        
        
        #if DEBUG
            DispatchQueue.main.async { [unowned self] in
                let fpsView = UISystemStatus();
                fpsView.x = 25;
                fpsView.centerY = self.window!.height - 75;
                self.window!.addSubview(fpsView)
            }
        #endif
    }
    
    private func registerNotification() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (isGranted, error) in
                if isGranted {
                    /* 允许通知 */
                } else {
                    /* 不允许通知 */
                }
            })
        } else {
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    //MARK: Method
    
    func setApplicationBadgeNumber(badgeNumber: Int) {
        if #available(iOS 9.0, *) {
            let settings = UIApplication.shared.currentUserNotificationSettings;
            if settings?.types.contains(.badge) ?? false {
                UIApplication.shared.applicationIconBadgeNumber = badgeNumber
            } else {
                #if DEBUG
                    print("Access denied for UIUserNotificationTypeBadge.")
                #endif
            }
        } else {
            UIApplication.shared.applicationIconBadgeNumber = badgeNumber
        }
    }
    
}
