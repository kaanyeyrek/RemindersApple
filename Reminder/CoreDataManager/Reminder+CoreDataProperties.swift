//
//  Reminder+CoreDataProperties.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/22/23.
//
//

import Foundation
import CoreData


extension Reminder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminder> {
        return NSFetchRequest<Reminder>(entityName: "Reminder")
    }

    @NSManaged public var flagged: Bool
    @NSManaged public var list: String?
    @NSManaged public var notes: String?
    @NSManaged public var priority: String?
    @NSManaged public var title: String?
    @NSManaged public var id: String?
    @NSManaged public var relation: ReminderList?

}

extension Reminder : Identifiable {

}
