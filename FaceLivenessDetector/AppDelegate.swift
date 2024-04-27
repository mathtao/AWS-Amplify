//
//  AppDelegate.swift
//  FaceLivenessDetector
//
//  Created by DN040801DDF on 24.09.2023.
//

import UIKit
import Amplify
import AWSCognitoAuthPlugin
import AWSAPIPlugin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func configureAmplify() {
        do {
            let auth = AWSCognitoAuthPlugin()
            let api = AWSAPIPlugin()
            try Amplify.add(plugin: auth)
            try Amplify.add(plugin: api)
            
            try Amplify.configure()
            
        } catch {
            print("Error configuring Amplify", error)
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureAmplify()
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

