//
//  ReminderList+CoreDataProperties.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/18/23.
//
//

import Foundation
import CoreData


extension ReminderList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReminderList> {
        return NSFetchRequest<ReminderList>(entityName: "ReminderList")
    }

    @NSManaged public var image: String?
    @NSManaged public var color: String?
    @NSManaged public var title: String?

}

extension ReminderList : Identifiable {

}
