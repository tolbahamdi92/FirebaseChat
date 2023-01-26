//
//  AppDelegate.swift
//  FirebaseChat
//
//  Created by Tolba on 26/06/1444 AH.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        screenRootApp()
        return true
    }

    private func gotoApp() {
        let navController = UINavigationController()
        let recentVC = UIStoryboard(name: StoryBoard.main, bundle: nil).instantiateViewController(identifier: ViewController.recentVC)
        window?.rootViewController = navController
        navController.pushViewController(recentVC, animated: true)
    }
    
    private func screenRootApp() {
        if let _ = UserFireBaseManager.shared.getCurrentUserID() {
            gotoApp()
        }
    }
}

