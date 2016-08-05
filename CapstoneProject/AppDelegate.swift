//
//  AppDelegate.swift
//  CapstoneProject
//
//  Created by Rahul Mehta on 7/7/16.
//  Copyright © 2016 Rahul. All rights reserved.
//

import UIKit
import Parse
import Bolts

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var storyboard : UIStoryboard?
    var storyboard1: UIStoryboard?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Parse.enableLocalDatastore()
        let configuration = ParseClientConfiguration {
            $0.applicationId = "quickfix"
            $0.server = "https://quickfix-parse-rm.herokuapp.com/parse"
            $0.clientKey = "dipti761"
        }
        
        PFUser.logOut()
        Parse.initializeWithConfiguration(configuration)
        Parse.setLogLevel(PFLogLevel.Debug)
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
    
        let currentUser = PFUser.currentUser()
        if (currentUser) != nil
        {
            if ((currentUser!["isBusiness"] as! Bool) == false)
            {
                self.storyboard?.instantiateViewControllerWithIdentifier("HomeScreen")
            }
            else
            {
                self.storyboard1?.instantiateViewControllerWithIdentifier("HomeScreenOfBusiness")
            }
        }
        else
        {
                self.storyboard?.instantiateViewControllerWithIdentifier("LaunchScreen")
        }
        return true
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




