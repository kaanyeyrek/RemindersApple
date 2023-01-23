//
//  HomeListViewModel.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/19/23.
//

import Foundation

protocol HomeListViewModelInterface {
    var view: HomeListViewInterface? { get set }
    func viewDidLoad()
    func registerTable()
    func heightForRowAt(at: IndexPath) -> CGFloat
    var numberOfRow: Int { get }
    func fetchData()
    func viewWillAppear()
    func cellForRow(at indexPath: IndexPath) -> Reminder?
}

final class HomeListViewModel {
    weak var view: HomeListViewInterface?
    private var lists: ReminderList
    private var manager: CoreDataManagerInterface
    private var remindResult = [Reminder]()
    
    init(lists: ReminderList, manager: CoreDataManagerInterface = CoreDataManager()) {
        self.lists = lists
        self.manager = manager
    }
}
//MARK: - HomeListViewModel Interface
extension HomeListViewModel: HomeListViewModelInterface {
    func viewWillAppear() {
        self.fetchData()
    }
    func viewDidLoad() {
        view?.setUI()
        view?.setSubviews()
        view?.setLayout()
        view?.setTableConfigure()
        registerTable()
    }
    func fetchData() {
        let result = manager.fetchRemindRelation() ?? []
        for remind in result {
            if remind.list == lists.title {
                self.remindResult.append(remind)
            }
        }
    }
    func registerTable() {
        view?.setRegisterTable()
    }
    func heightForRowAt(at: IndexPath) -> CGFloat {
        .init(60)
    }
    var numberOfRow: Int {
        remindResult.count
    }
    func cellForRow(at indexPath: IndexPath) -> Reminder? {
        remindResult.count > indexPath.row ? remindResult[indexPath.row] : nil
    }
}
