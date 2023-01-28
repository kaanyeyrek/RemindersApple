//
//  HomeDetailListViewModel.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/26/23.
//

import Foundation
import CoreData

protocol HomeDetailListViewModelInterface {
    var view: HomeDetailListTableViewCell? { get set }
    func viewDidLoad()
    func savedEditReminderTitle(reminderID: String)
}

final class HomeDetailListViewModel {
    weak var view: HomeDetailListTableViewCell?
    private var manager: CoreDataManagerInterface
    
    init(view: HomeDetailListTableViewCell, manager: CoreDataManagerInterface = CoreDataManager()) {
        self.view = view
        self.manager = manager
    }
}
//MARK: - HomeDetailListViewModel Interface
extension HomeDetailListViewModel: HomeDetailListViewModelInterface {
    func viewDidLoad() {
        view!.setUI()
        view?.setGesture()
        view?.setAddSubviews()
        view?.setLayout()
    }
    func savedEditReminderTitle(reminderID: String) {
        guard let title = view?.editingTitle else { return }
            
        let result = manager.fetchRemindRelation() ?? []
            guard let foundReminder = result.first(where: { reminder in
                reminder.id == reminderID
            }) else { return }
        foundReminder.title = title
        manager.save()
        }
    }

