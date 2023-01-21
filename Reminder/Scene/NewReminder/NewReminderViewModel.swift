//
//  NewReminderViewModel.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/19/23.
//

import Foundation

protocol NewReminderViewModelInterface {
    func viewDidLoad()
    func numberOfRowsInSection(with section: Int) -> Int
    func heightForRowAt(with indexPath: IndexPath) -> CGFloat
    func registerTable()
    var numberOfSections: Int { get }
    var numberOfPickerComponents: Int { get }
    var numberOfRowsInComponent: Int { get }
    func viewWillAppear()
    func updateData()
}

final class NewReminderViewModel {
    private weak var view: NewReminderViewInterface?
    private var currentLists: [ReminderList] = []
    private var manager: CoreDataManagerInterface
    
    init(view: NewReminderViewInterface, manager: CoreDataManagerInterface = CoreDataManager()) {
        self.view = view
        self.manager = manager
    }
}
//MARK: - NewReminderViewModel Interface
extension NewReminderViewModel: NewReminderViewModelInterface {
    // Helper
    private func notify(with output: ListOutput) {
        view?.handleOutput(output: output)
    }
    func viewWillAppear() {
        currentLists = manager.fetch() ?? []
        updateData()
    }
    func viewDidLoad() {
        view?.setUI()
        view?.setSubviews()
        view?.setNavbar()
        view?.setLayout()
        registerTable()
    }
    func updateData() {
        let list = self.currentLists.map({
            ReminderListPresentation(model: $0)
        })
        self.notify(with: .listPresentation(with: list))
    }
    func registerTable() {
        view?.configureTable()
    }
    var numberOfSections: Int {
        return 4
    }
    func numberOfRowsInSection(with section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 1
        default:
            return 0
        }
    }
    func heightForRowAt(with indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 1 {
            return 120
        }
        else {
            return 50
        }
    }
    var numberOfPickerComponents: Int {
        return 1
    }
    var numberOfRowsInComponent: Int {
        return currentLists.count
    }
}
