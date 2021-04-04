//
//  Meal+CoreDataProperties.swift
//  MealTimeCoreData
//
//  Created by Андрей Моисеев on 04.04.2021.
//
//

import Foundation
import CoreData


extension Meal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meal> {
        return NSFetchRequest<Meal>(entityName: "Meal")
    }

    @NSManaged public var date: Date?
    @NSManaged public var user: User?

}

extension Meal : Identifiable {

}
