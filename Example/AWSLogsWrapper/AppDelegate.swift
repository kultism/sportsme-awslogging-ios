//
//  AppDelegate.swift
//  AWSLogsWrapper
//
//  Created by rajasekhar.pattem@tarams.com on 04/14/2020.
//  Copyright (c) 2020 rajasekhar.pattem@tarams.com. All rights reserved.
//

import UIKit
import AWSLogsWrapper
import AWSLogs

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ///if you are using AWSLogsWrapper, calling Logger.configure() in didFinishLaunching function is mandatory
        AWSLogsService.shared.configure()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

class AWSLogsService : LoggerDelegate {
    static let shared = AWSLogsService()
    private init() {
        Logger.delegate = self
    }
    func configure() {
        let credentialProvider = AWSCognitoCredentialsProvider(regionType: .APEast1, identityPoolId: "Pool Id")
        if let serviceConfig = AWSServiceConfiguration(region:.APEast1, credentialsProvider:credentialProvider) {
            Logger.configure(with: serviceConfig , awsLogKey: "Log Key", awsGroupName: "Log group name", awsStreamName: "log stream name", deviceId: "Device Id", userId: "UseraId", sessionId: "SeesionId", buildType: .development)
        }
    }
    
    func loggingEventFailed(message: String, timestamp: NSNumber, error: UploadToAWSError) {
        print("Log Event Failed !!!! error: \(error.errorDescription ?? "") errorCode: \(error.errorCode)")
    }
    
    func loggingEventSuccess(message: String, timestamp: NSNumber, nextSequenceToken: String) {
        print("MESSAGE: \(message)")
    }
}
