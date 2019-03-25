//
//  AppDelegate.swift
//  DemoConfigUserDefined
//
//  Created by Tam Nguyen M. on 3/24/19.
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
        print(Config.endpoint)
        #if ONE
        print("ONE")
        #else
        print("TWO")
        #endif
        return true
    }
}

class Config {
    static var endpoint: String {
        get {
            guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
                let dic = NSDictionary(contentsOfFile: path),
                let endpoint = dic["ENDPOINT_URL"] as? String else { return "No endpoint in Info.plist" }
            return endpoint
        }
    }
}

