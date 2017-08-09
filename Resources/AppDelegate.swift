//
//  AppDelegate.swift
//  Player
//
//  Created by Келбин on 06.07.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        audioInit()
        return true
    }
    
    func audioInit() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
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


}

