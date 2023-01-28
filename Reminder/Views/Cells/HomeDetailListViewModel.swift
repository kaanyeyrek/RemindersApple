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
    func savedEditReminderTitle()
}

final class HomeDetailListViewModel {
    weak var view: HomeDetailListTableViewCell?
    private var manager: CoreDataManagerInterface
    private var currentList: [ReminderList] = []
    
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
        currentList = manager.fetch() ?? []
    }
    func savedEditReminderTitle() {
        if let title = view?.editingTitle {
            guard let context = CoreDataManager().context else { return }
            let remind = Reminder(context: context)
                
                remind.title = title
                manager.save()
             
            }
        }
//        let result = manager.fetchRemindRelation() ?? []
//        for remind in result {
//
//            remind.title = view?.editingTitle
//            manager.save()
//        }
    }

