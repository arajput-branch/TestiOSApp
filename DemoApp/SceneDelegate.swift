//
//  SceneDelegate.swift
//  DemoApp
//
//  Created by Aastha Rajput on 12/30/19.
//  Copyright © 2019 Aastha Rajput. All rights reserved.
//

import UIKit
import SwiftUI
import Branch

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
    
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let testController = UIHostingController(rootView: contentView)
            let buo = BranchUniversalObject.init(canonicalIdentifier: "content/12345")
            buo.title = "----My First testing link----"
            buo.contentDescription = "My Content Description"
            buo.imageUrl = "https://lorempixel.com/400/400"
            buo.publiclyIndex = true
            buo.locallyIndex = true
            buo.contentMetadata.customMetadata["customKey"] = "ANY CUSTOM DATA"
            
            let lp: BranchLinkProperties = BranchLinkProperties()
            lp.channel = "facebook"
            lp.feature = "sharing"
            lp.campaign = "content 123 launch"
            lp.stage = "new user"
            lp.tags = ["one", "two", "three"]

            lp.addControlParam("$desktop_url", withValue: "http://example.com/desktop")
            lp.addControlParam("$ios_url", withValue: "http://example.com/ios")
            lp.addControlParam("$ipad_url", withValue: "http://example.com/ios")
            lp.addControlParam("$android_url", withValue: "http://example.com/android")
            lp.addControlParam("$match_duration", withValue: "2000")

            lp.addControlParam("custom_data", withValue: "yes")
            lp.addControlParam("look_at", withValue: "this")
            lp.addControlParam("nav_to", withValue: "over here")
            lp.addControlParam("random", withValue: UUID.init().uuidString)
            
            buo.getShortUrl(with: lp) { (url, error) in
                print(url ?? "")
            }
            
            let message = "Check out this link"
            buo.showShareSheet(with: lp, andShareText: message, from: testController) {
                (activityType, completed) in
                print(activityType ?? "")
            }
            
            window.rootViewController = testController

          
            self.window = window
            window.makeKeyAndVisible()
        } 
        
        
               
         // guard let _ = (scene as? UIWindowScene) else { return }
          // workaround for SceneDelegate continueUserActivity not getting called on cold start
          if let userActivity = connectionOptions.userActivities.first {
              Branch.getInstance().continue(userActivity)
          }
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        NSLog("Branch: scene.continueUserActivity")
        // direct mapping to existing Branch API
        Branch.getInstance().continue(userActivity)
    }
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        NSLog("Brancccch: scene.openURL")
        if let context = URLContexts.first {
            Branch.getInstance().application(nil, open: context.url, sourceApplication: context.options.sourceApplication, annotation: context.options.annotation)
        }
    }


}

