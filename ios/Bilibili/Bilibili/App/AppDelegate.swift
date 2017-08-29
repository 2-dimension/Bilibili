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
import BilibiliAPI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // Mark: Life Cycle
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setup()
        //test()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    
    //MARK: Misc
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        // URLNavigator Handler
        if Navigator.open(url) {
            return true
        }
        
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        
        // Spotlight
        if userActivity.activityType == CSSearchableItemActionType {
            
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
    
    private func setup() {
        //FIXME: Method not implemented.
        
        // Setup exception handler.
        NSSetUncaughtExceptionHandler { (exception) in
            print("Exception: \(exception.name)")
            print("Reason: \(exception.reason ?? "")")
            print("Call Stack:")
            for symbol in exception.callStackSymbols {
                print(symbol)
            }
        }
    }
    
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
    
}
