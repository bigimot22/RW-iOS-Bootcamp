//
//  Sandwich+CoreDataProperties.swift
//  SandwichSaturation
//
//  Created by Johandre Delgado  on 19.07.2020.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
//

import Foundation
import CoreData


extension Sandwich {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sandwich> {
        return NSFetchRequest<Sandwich>(entityName: "Sandwich")
    }

    @NSManaged public var name: String?
    @NSManaged public var sauceAmount: Int16
    @NSManaged public var imageName: String?

}
