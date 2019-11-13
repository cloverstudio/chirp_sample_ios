//
//  AppDelegate.swift
//  ChirpExample
//
//  Created by CloverField on 06/11/2019.
//  Copyright © 2019 CloverField. All rights reserved.
//

import UIKit
import ChirpSDK

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var chirpService: ChirpManager?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        chirpService = ChirpManager()
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


    func applicationWillResignActive(_ application: UIApplication) {
            if self.chirpService!.chirp?.state != CHIRP_SDK_STATE_STOPPED {
                if let error = self.chirpService!.chirp!.stop() {
                    print(error.localizedDescription)
                }
            }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
            if self.chirpService!.chirp?.state != CHIRP_SDK_STATE_STOPPED {
                if let error = self.chirpService!.chirp!.stop() {
                    print(error.localizedDescription)
                }
            }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
            if self.chirpService!.chirp?.state == CHIRP_SDK_STATE_STOPPED {
                if let error = self.chirpService!.chirp!.start() {
                    print(error.localizedDescription)
                }
            }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
            if self.chirpService!.chirp?.state == CHIRP_SDK_STATE_STOPPED {
                if let error = self.chirpService!.chirp!.start() {
                    print(error.localizedDescription)
                }
            }
    }

    func applicationWillTerminate(_ application: UIApplication) {
            if self.chirpService!.chirp?.state != CHIRP_SDK_STATE_STOPPED {
                if let error = self.chirpService!.chirp!.stop() {
                    print(error.localizedDescription)
                }
            }
    }
    
}

