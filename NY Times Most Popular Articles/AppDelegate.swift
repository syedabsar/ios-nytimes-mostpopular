//
//  AppDelegate.swift
//  NY Times Most Popular Articles
//
//  Created by Syed Absar Karim on 8/4/17.
//  Copyright © 2017 Syed Absar Karim. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.configureAppearance()
        
        let splitViewController = window!.rootViewController as! UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        splitViewController.delegate = self
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

    // MARK: - Appearance Configuration
    func configureAppearance() {
        
        /* Note: In my opinion, this is not the best approach to handle appearances. Having it here as it is optional anyways.
         I can explain the best approach or revise the code later on.
         - Syed Absar
         */
        let themeColor = UIColor.init(colorLiteralRed: 63.0/255.0, green: 225.0/255.0, blue: 180.0/255.0, alpha: 1.0)
        
        /* UINavigationBar Appearance */

        // Set navigation bar tint / background colour
        UINavigationBar.appearance().barTintColor = themeColor
        
        // Set Navigation bar Title colour
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        
        // Set navigation bar ItemButton tint colour
        UIBarButtonItem.appearance().tintColor = UIColor.white
        
        //Set navigation bar Back button tint colour
        UINavigationBar.appearance().tintColor = UIColor.white
        
        //Transcluency off to align the background colors of navigation bar and bar button items
        UINavigationBar.appearance().isTranslucent = false
        
        /* UISearchBar Appearance */
        UISearchBar.appearance().tintColor = UIColor.white
        
        UISearchBar.appearance().barTintColor = themeColor
        
        /* UIButton Appearance */
        UIButton.appearance().backgroundColor = themeColor
        
        UIButton.appearance(whenContainedInInstancesOf: [UITableViewCell.self]).backgroundColor = nil
        
        UIButton.appearance(whenContainedInInstancesOf: [UITableViewCell.self]).tintColor = nil
    }
    
    // MARK: - Split view

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        if topAsDetailController.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }

}

