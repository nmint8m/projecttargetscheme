//
//  AppDelegate.swift
//  DemoSettings
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
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        window?.rootViewController = RootVC()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        SettingsBundleHelper.checkAndExecuteSettings()
        SettingsBundleHelper.setVersionAndBuildNumber()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

let ud = UserDefaults.standard

class SettingsBundleHelper {

    struct SettingsBundleKeys {
        static let kReset = "K_RESET_APP"
        static let kBuild = "K_APP_BUILD"
        static let kVersion = "K_APP_VERSION"
        static let kCopyright = "K_APP_COPYRIGHT"
        static let kEndpoint = "K_APP_ENDPOINT"
    }

    struct InforKeys {
        static let kBuild = "IS_APP_BUILD"
        static let kVersion = "IS_APP_VERSION"
        static let kCopyright = "IS_APP_COPYRIGHT"
    }

    static func checkAndExecuteSettings() {
        if ud.bool(forKey: SettingsBundleKeys.kReset) {
            ud.set(false, forKey: SettingsBundleKeys.kReset)
        }
    }

    static func setVersionAndBuildNumber() {
        let build = getInfo(key: InforKeys.kBuild)
        let version = getInfo(key: InforKeys.kVersion)
        let copyright = getInfo(key: InforKeys.kCopyright)

        ud.set(build, forKey: SettingsBundleKeys.kBuild)
        ud.set(version, forKey: SettingsBundleKeys.kVersion)
        ud.set(copyright, forKey: SettingsBundleKeys.kCopyright)
    }

    static func getInfo(key: String) -> String {
        guard let dic = Bundle.main.infoDictionary,
            let value = dic[key] as? String else { return "" }
        return value
    }
}
