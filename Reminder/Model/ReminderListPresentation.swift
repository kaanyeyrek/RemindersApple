//
//  ReminderListPresentation.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/21/23.
//

import Foundation

struct ReminderListPresentation {
    let title: String?
    let image: String?
    let color: String?
    
init(model: ReminderList) {
        self.title = model.title
        self.image = model.image
        self.color = model.color
    }
}

