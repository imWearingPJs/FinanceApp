//
//  AppDelegate.swift
//  KozyFinance
//
//  Created by Michael Kozub on 4/30/19.
//  Copyright © 2019 Michael Kozub. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let vc = ViewController()
        self.window?.rootViewController = UINavigationController(rootViewController: vc)
        self.window?.makeKeyAndVisible()
        return true
    }

}
