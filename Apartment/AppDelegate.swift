//
//  AppDelegate.swift
//  Apartment
//
//  Created by Eric Abell on 11/25/15.
//  Copyright © 2015 SASInnovationCenter. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ESTBeaconManagerDelegate {

    var window: UIWindow?
    var beaconManager = ESTBeaconManager()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Set the beacon manager's delegate
        // Since AppDelegate inherits from ESTBeaconManagerDelagate,
        // we can assign self to self.beaconManager.delegate
        self.beaconManager.delegate = self;
        
        // Good to request authorization...
        self.beaconManager.requestAlwaysAuthorization();
        
        UIApplication.sharedApplication().registerUserNotificationSettings(
            UIUserNotificationSettings(forTypes: .Alert, categories: nil))
        
        // I'm only specifying the UUID -- which I think means that all 4 beacons in
        // the apartment will serve as a *REGION* and I'm hoping this eliminates the
        // repeating "enter" messages I'm getting...
        self.beaconManager.startMonitoringForRegion(CLBeaconRegion(
            proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!,
            /*major: 65344 , minor: 50164 ,*/ identifier: "apartment"
            ) );
        
        return true
    }
    
    func beaconManager(manager: AnyObject, didEnterRegion region: CLBeaconRegion) {
        let notification = UILocalNotification()
        notification.alertBody =
            "Welcome Home Eric! " +
            "It looks like you just walked into your " +
            "apartment. "
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
        print("Enter Region called.")
    }

    func beaconManager(manager: AnyObject, didExitRegion region: CLBeaconRegion) {
        let notification = UILocalNotification()
        notification.alertBody =
            "Goodbye Eric!" +
            "It looks like you just left your " +
            "apartment. "
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
        print("Exit Region called.")
    }

    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

