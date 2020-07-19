//
//  CoreDataManager.swift
//  SandwichSaturation
//
//  Created by Johandre Delgado  on 19.07.2020.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager: NSObject {
  lazy var persisitentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "SandwichData")
    container.loadPersistentStores(completionHandler: {
      (storeDescription, error) in
      print("storeDescription: \(storeDescription)")
      if let error = error as NSError? {
        fatalError("Unresolved container error: \(error), \(error.userInfo) ")
      }
    })
    return container
  }()

  func saveContext() {
    let context = persisitentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        fatalError("Unresolved context saving error: \(error), \(error.localizedDescription) ")
      }
    }
  }

   func preloadData() {
    let preloadkey = "didPreloadData"
    let defaults = UserDefaults.standard

    if !defaults.bool(forKey: preloadkey) {
      guard let sandwiches = loadSandwiches() else { return }
      let context = persisitentContainer.viewContext
      print("context: \(context)")
      for item in sandwiches {
//        let sandwich = Sandwich(entity: Sandwich.entity(), insertInto: context)

        let sandwich = NSEntityDescription.insertNewObject(forEntityName: "Sandwich", into: context) as! Sandwich
        sandwich.name = item.name
        sandwich.sauceAmount = item.sauceAmount.rawValue
        sandwich.imageName = item.imageName
      }
      saveContext()
      defaults.set(true, forKey: preloadkey)
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Sandwich")
      let count = try? context.count(for: fetchRequest)
      print("\(String(describing: count))")
    }

    print("preloadkey = \(defaults.bool(forKey: preloadkey))")

  }


    func loadSandwiches() -> [SandwichData]? {
      var loadedSandwiches: [SandwichData]? = nil
    let filename = "sandwiches"
    let decoder = JSONDecoder()

    guard let fileURL = Bundle.main.url(forResource: filename,
                                        withExtension: "json") else {
                                          print("Couldn't find \(filename) in main bundle.")
                                          return nil
    }

    do {
      let data = try Data(contentsOf: fileURL)
      loadedSandwiches =  try decoder.decode([SandwichData].self, from: data)
//      sandwiches.append(contentsOf: sandwichArray)
    } catch let error {
      print("Couldn't parse \(filename) as \(SandwichData.self): \n\(error)")
    }
      print("json loadedSandwiches. count: \(String(describing: loadedSandwiches?.count))")
      return loadedSandwiches
  }

  func fetchSandwiches() -> [Sandwich] {
    var sandwiches: [Sandwich] = []
    let context = persisitentContainer.viewContext
    do {
      sandwiches = try context.fetch(Sandwich.fetchRequest())
      print("store sandwiches loaded. Count: \(sandwiches.count)")
    } catch let error {
      print(error.localizedDescription)
    }
    return sandwiches
  }

}
