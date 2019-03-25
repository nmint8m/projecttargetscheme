//
//  AppDelegate.swift
//  DemoConfigXCConfig
//
//  Created by Tam Nguyen M. on 3/25/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        window?.rootViewController = UIViewController()
        print(Config.info)
        #if ST
        print("ST")
        #else
        print("ND")
        #endif
        return true
    }
}

class Config {
    static var info: String {
        get {
            guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
                let dic = NSDictionary(contentsOfFile: path),
                let property = dic["A_PROPERTY"] as? String else { return "No property in Info.plist" }
            return property
        }
    }
}
