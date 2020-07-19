//
//  AppDelegate.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  let coredataManager = CoreDataManager()

//  lazy var persisitentContainer: NSPersistentContainer = {
//    let container = NSPersistentContainer(name: "Sandwich")
//    container.loadPersistentStores(completionHandler: {
//      (storeDescription, error) in
//      print("storeDescription: \(storeDescription)")
//      if let error = error as NSError? {
//        fatalError("Unresolved container error: \(error), \(error.userInfo) ")
//      }
//    })
//    return container
//  }()
//
//  func saveContext() {
//    let context = persisitentContainer.viewContext
//    if context.hasChanges {
//      do {
//        try context.save()
//      } catch {
//        fatalError("Unresolved context saving error: \(error), \(error.localizedDescription) ")
//      }
//    }
//  }
//
//  private func preloadData() {
//    let preloadkey = "didPreloadData"
//    let defaults = UserDefaults.standard
//    if !defaults.bool(forKey: preloadkey) {
//      // load json and set coredata
//      defaults.set(true, forKey: preloadkey)
//      print("preloadkey = \(defaults.bool(forKey: preloadkey))")
//    }
//
//  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    coredataManager.preloadData()
    return true
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

