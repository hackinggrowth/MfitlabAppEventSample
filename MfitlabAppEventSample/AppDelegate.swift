//
//  AppDelegate.swift
//  MfitlabAppEventSample
//
//  Created by Dohyung Park on 2022/03/29.
//

import UIKit
import AppTrackingTransparency

import FBSDKCoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func initFacebookSDK(){
        Settings.shared.isAutoLogAppEventsEnabled = true
        Settings.shared.isAdvertiserIDCollectionEnabled = true
        ApplicationDelegate.initialize()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        Settings.shared.isAutoLogAppEventsEnabled = true
        // NOTE: 디버깅 목적으로 AppEvent 발생 건과 Network Request 발생을 로깅한다.
        Settings.shared.enableLoggingBehavior(.appEvents)
        Settings.shared.enableLoggingBehavior(.networkRequests)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if #available(iOS 14, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .authorized:           // 허용됨
                        Settings.shared.isAdvertiserTrackingEnabled = true
                        print("Authorized")
                    case .denied:               // 거부됨
                        print("Denied")
                    case .notDetermined:        // 결정되지 않음
                        print("Not Determined")
                    case .restricted:           // 제한됨
                        print("Restricted")
                    @unknown default:           // 알려지지 않음
                        print("Unknow")
                    }
                }
                self.initFacebookSDK();
            } else {
                self.initFacebookSDK();
            }
        }
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

