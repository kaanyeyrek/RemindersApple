//
//  HomeViewModelContracts.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/15/23.
//

import Foundation

enum HomeViewModelRoute {
    case addNewList
    case addNewReminder
    case detail(viewModel: HomeListViewModelInterface)
}
enum HomeViewModelOutput {
    case showEmptyView(message: String)
    case removeEmpty
}
