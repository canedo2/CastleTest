//
//  AppDelegate.swift
//  CastleTest
//
//  Created by Diego Manuel Molina Canedo on 3/12/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = Assembler.assembly.assembleCastleViewController()
        window?.makeKeyAndVisible()
        return true
    }

}

