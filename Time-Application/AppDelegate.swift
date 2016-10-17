//
//  AppDelegate.swift
//  Time-Application
//
//  Created by Даниил on 16.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        URLCache.shared.removeAllCachedResponses()
        
        registerForPushNotifications(application)
        
        setNavigationBarAppereance()
        
        setCorrectInitialController()
        
        setUITableViewCellSelectionColor()
        
        return true
    }

    func setNavigationBarAppereance() {
        
        let font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightRegular)
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSFontAttributeName : font,
            NSForegroundColorAttributeName : UColor.greyContentColor
        ]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: font], for: UIControlState())
    }

    func setCorrectInitialController() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let jsonURI = Defaults.userSchedule() {
            
            let initialViewController =
                storyboard.instantiateViewController(withIdentifier: "L5") as! UINavigationController
            
            let destination = initialViewController.topViewController as! L5TableViewController
            
            destination.jsonURI = jsonURI
            destination.isInitial = true
            
            window?.rootViewController = initialViewController
            
        } else {
            
            let initialViewController =
                storyboard.instantiateViewController(withIdentifier: "root") as! UINavigationController
            
            window?.rootViewController = initialViewController
        }
        
        window?.makeKeyAndVisible()
    }
    
    func setUITableViewCellSelectionColor() {
        
        let colorView = UIView()
        
        colorView.backgroundColor = UColor.lightBlueContentColor
        
        UITableViewCell.appearance().selectedBackgroundView = colorView
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        print("DEVICE TOKEN = \(deviceToken)")
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {

        print(error)
    }
    
    func registerForPushNotifications(_ application: UIApplication) {
        
        let notificationSettings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
        
        application.registerUserNotificationSettings(notificationSettings)
    }
}

