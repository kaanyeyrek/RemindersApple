//
//  CoreDataManager.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/18/23.
//

import UIKit
import CoreData

protocol CoreDataManagerInterface {
    func save()
    func fetch() -> [ReminderList]?
    func delete(model: ReminderList)
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
}
