//
//  ReminderPresentation.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/24/23.
//

import Foundation

struct ReminderPresentation: Equatable {
    let remindFlagged: Bool?
    let remindTitle: String?
    let remindNotes: String?
    let remindPriority: String?
    let remindList: String?
    let remindID: String?
    
    init(model: Reminder) {
        self.remindFlagged = model.flagged
        self.remindTitle = model.title
        self.remindNotes = model.notes
        self.remindPriority = model.priority
        self.remindList = model.list
        self.remindID = model.id
    }
}

