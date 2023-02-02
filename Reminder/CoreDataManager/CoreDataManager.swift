//
//  CoreDataManager.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 2/2/23.
//

import UIKit
import CoreData

protocol CoreDataManagerInterface {
    func save()
    func fetch() -> [ReminderList]?
    func delete(model: ReminderList)
    func fetchRemindRelation() -> [Reminder]?
    func deleteRemindRelation(model: Reminder)
    func searchFilterList(query: String) -> NSPredicate
}

final class CoreDataManager {
//MARK: - Components
    var context: NSManagedObjectContext? {
       let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        return context
    }
}
//MARK: - CoreDataManager Interface
extension CoreDataManager: CoreDataManagerInterface {
    func save() {
        do {
            try context?.save()
        } catch {
            fatalError("failed save")
        }
    }
    func fetch() -> [ReminderList]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ReminderList")
        do {
            let fetchedTask = try context?.fetch(request) as? [ReminderList]
            return fetchedTask?.reversed()
        } catch {
            fatalError("failed fetch")
        }
    }
    func delete(model: ReminderList) {
        context?.delete(model)
        try? context?.save()
    }
    // filter
    func searchFilterList(query: String) -> NSPredicate {
        let request: NSFetchRequest<ReminderList> = ReminderList.fetchRequest()
        request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", query)
        return request.predicate!
    }
//MARK: - Relation Methods
    func fetchRemindRelation() -> [Reminder]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Reminder")
        do {
            let fetchedTask = try context?.fetch(request) as? [Reminder]
            return fetchedTask?.reversed()
        } catch {
            fatalError("failed fetch")
        }
    }
    func deleteRemindRelation(model: Reminder) {
        context?.delete(model)
        try? context?.save()
    }
}
