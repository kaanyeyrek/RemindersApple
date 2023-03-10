//
//  HomeListViewModel.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/19/23.
//

import Foundation

protocol HomeListViewModelInterface {
    var view: HomeListViewInterface? { get set }
//    func cellForRow(at indexPath: IndexPath) -> Reminder?
    func viewDidLoad()
    func registerTable()
    func heightForRowAt(at: IndexPath) -> CGFloat
    var numberOfRow: Int { get }
    func fetchData()
    func viewWillAppear()
    func newReminderButton()
    func deletedRemind(indexPath: IndexPath)
}

final class HomeListViewModel {
    weak var view: HomeListViewInterface?
    private var lists: ReminderList?
    private var manager: CoreDataManagerInterface
    private var remindResult: [Reminder] = []
    
    init(lists: ReminderList, manager: CoreDataManagerInterface = CoreDataManager()) {
        self.lists = lists
        self.manager = manager
        print(remindResult.count)
    }
}
//MARK: - HomeListViewModel Interface
extension HomeListViewModel: HomeListViewModelInterface {
    func viewWillAppear() {
        self.fetchData()
        view?.setNavBarTitleColor(model: lists!)
        }
    func viewDidLoad() {
        view?.setUI()
        view?.setSubviews()
        view?.setLayout()
        view?.setTarget()
        view?.setTableConfigure()
        view?.setTitle(model: lists!)
        registerTable()
    }
    func newReminderButton() {
        view?.navigate(route: .newReminder)
    }
    func fetchData() {
        let result = manager.fetchRemindRelation() ?? []
        view?.tableReload()
        for remind in result {
            if remind.list == lists?.title {
                self.remindResult.append(remind)
                let remindList = self.remindResult.map({
                    ReminderPresentation(model: $0)})
                self.notify(output: .loadRemindPresentation(presentation: remindList))
            }
        }
        if self.remindResult.isEmpty {
            self.notify(output: .showEmptyView(message: "No Reminders"))
        } else {
            self.notify(output: .removeEmpty)
        }
    }
// Helper
    private func notify(output: HomeListOutput) {
        view?.setHandlePresentation(output: output)
    }
    func registerTable() {
        view?.setRegisterTable()
    }
    func heightForRowAt(at: IndexPath) -> CGFloat {
        .init(70)
    }
    var numberOfRow: Int {
        remindResult.count
    }
//    func cellForRow(at indexPath: IndexPath) -> Reminder? {
//        remindResult.count > indexPath.row ? remindResult[indexPath.row] : nil
//    }
    func deletedRemind(indexPath: IndexPath) {
        guard let context = CoreDataManager().context else { return }
            context.delete(self.remindResult[indexPath.row])
            self.remindResult.remove(at: indexPath.row)
            manager.save()
        DispatchQueue.main.async {
            self.view?.tableReload()
        }
    }
}
