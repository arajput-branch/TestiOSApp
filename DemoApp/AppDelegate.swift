//
//  AppDelegate.swift
//  DemoApp
//
//  Created by Aastha Rajput on 12/30/19.
//  Copyright © 2019 Aastha Rajput. All rights reserved.
//

import UIKit
import Branch

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
         //let branch = Branch.getInstance()
      // if you are using the TEST key
    /* Branch.setUseTestBranchKey(true)
      // listener for Branch Deep Link data
      Branch.getInstance().initSession(launchOptions: launchOptions) { (params, error) in
        // do stuff with deep link data (nav to page, display content, etc)
        print(params as? [String: AnyObject] ?? {})
      }*/
        
        // Override point for customization after application launch.

        let branch = Branch.getInstance()
        branch.initSession(launchOptions: launchOptions, andRegisterDeepLinkHandler: { (params, error) in
            if let safe = params {
                NSLog("Branch: %@", safe)
            }
           
            // latest
            //let sessionParams = Branch.getInstance().getLatestReferringParams()

            // first
            //let installParams = Branch.getInstance().getFirstReferringParams()
            
        })
      return true

    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
