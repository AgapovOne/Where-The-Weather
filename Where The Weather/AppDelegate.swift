//
//  AppDelegate.swift
//  Where The Weather
//
//  Created by Alex Agapov on 13/04/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let controller = StoryboardScene.Main.initialScene.instantiate()
        window?.rootViewController = controller
        window?.makeKeyAndVisible()

        return true
    }
}
