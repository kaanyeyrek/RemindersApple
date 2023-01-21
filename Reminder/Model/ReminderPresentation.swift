//
//  ReminderPresentation.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/19/23.
//

import Foundation

struct ReminderPresentation {
    let title: String
    
    init(model: ReminderList) {
        self.title = model.title ?? ""
    }
}

