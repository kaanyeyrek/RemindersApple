//
//  HomeListContracts.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/22/23.
//

import Foundation

enum HomeListOutput {
    case loadRemindPresentation(presentation: [ReminderPresentation])
    case showEmptyView(message: String)
    case removeEmpty
}
enum HomeListRoute {
    case newReminder
}
