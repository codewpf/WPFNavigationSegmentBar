//
//  AppDelegate.swift
//  NavTest
//
//  Created by Alex on 13/04/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        
        let vc = MainVC()
        let nav = UINavigationController(navigationBarClass: DTProgressNavigationBar.self, toolbarClass: nil)
        nav.viewControllers = [vc]
        self.window?.rootViewController = nav
        
        
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
        
        return true
    }


}
