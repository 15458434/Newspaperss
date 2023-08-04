//
//  AppDelegate.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 30/07/2023.
//

import UIKit
import GoogleMobileAds

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    @objc dynamic var adMobState: GADAdapterStatus?
    
    func startGoogleAds() {
        GADMobileAds.sharedInstance().start { status in
            let adapterStatusesByClassName = status.adapterStatusesByClassName
            self.adMobState = adapterStatusesByClassName["GADMobileAds"]
        }
        let iPhone11ProMarkID = "e1e7c0fe434a85ce976f84098f5ce9d2"
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ GADSimulatorID, iPhone11ProMarkID ]
    }
    
    // MARK: UIApplicationDelegate

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        startGoogleAds()
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with
        let configuration = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        configuration.delegateClass = SceneDelegate.self
        return configuration
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

