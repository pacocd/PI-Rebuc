//
//  AppDelegate.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 12/09/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setInitialFlow()
        setAppColors()
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().toolbarTintColor = UIColor.greenUcolTab
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
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

extension AppDelegate {

    /// Determine App initial View Controller if there is an user logged or not
    func setInitialFlow() {
        var navigationController: UINavigationController?
        if UserManager.shared.isUserLogged() {
            let viewController: UIViewController = UIViewController().instantiate(viewController: "TicketsViewController", storyboard: "Tickets")
            navigationController = UINavigationController(rootViewController: viewController)

            APIManager.shared.getUser(success: { (user, headers) in
                UserManager.shared.user = user
                UserManager.shared.update(token: headers["Access-Token"] as? String)
                NotificationCenter.default.post(name: .userDidSet, object: nil)
            })
        } else {
            let viewController: UIViewController = UIViewController().instantiate(viewController: "LoginViewController", storyboard: "Authentication")
            navigationController = UINavigationController(rootViewController: viewController)
        }

        window?.rootViewController = navigationController

    }

    /// Configure App Color set
    func setAppColors() {
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().backgroundColor = UIColor.greenUcolTab
        UINavigationBar.appearance().barTintColor = UIColor.greenUcolTab
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]

        UIApplication.shared.statusBarStyle = .lightContent
    }

}
