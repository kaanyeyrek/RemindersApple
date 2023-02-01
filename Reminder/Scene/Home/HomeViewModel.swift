//
//  HomeViewModel.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/15/23.
//

import Foundation

protocol HomeViewModelInterface {
    func viewWillAppear()
    func viewDidLoad()
    func didTappedAddListButton()
    func didTappedNewReminderButton()
    var numberOfRowsInSection: Int { get }
//    func cellForItem(at indexPath: IndexPath) -> ReminderList?
    func didSelectForRow(at index: Int)
    func fetchReminder()
}

final class HomeViewModel {
    private weak var view: HomeViewInterface?
    private var reminderModel = [ReminderList]()
    private var reminderListModel: [Reminder] = []
    private var manager: CoreDataManagerInterface
    
    init(view: HomeViewInterface, manager: CoreDataManagerInterface = CoreDataManager()) {
        self.view = view
        self.manager = manager
    }
}
//MARK: - HomeViewModelInterface Methods
extension HomeViewModel: HomeViewModelInterface {
    func viewWillAppear() {
        reminderModel = manager.fetch() ?? []
        view?.reloadData()
        let presentation = self.reminderModel.map({
            ReminderListPresentation(model: $0)
        })
        notify(output: .loadPresentation(presentation: presentation))
        if self.reminderModel.isEmpty {
            self.notify(output: .showEmptyView(message: "No List"))
        } else {
            self.notify(output: .removeEmpty)
        }
    }
    func fetchReminder() {
        reminderListModel = manager.fetchRemindRelation() ?? []
        view?.reloadData()
        let presentation = self.reminderListModel.map({
            ReminderPresentation(model: $0)
        })
        notify(output: .reminderCountPresentation(presentation: presentation))
    }
    func viewDidLoad() {
        view?.setUI()
        view?.setAddSubviews()
        view?.setLayout()
        view?.setSearchController()
        view?.setTableView()
        view?.setTarget()
        view?.setCountLabel()
    }
// Helper
    private func notify(output: HomeViewModelOutput) {
        view?.setHandleOutput(output: output)
    }
    func didTappedAddListButton() {
        view?.navigate(with: .addNewList)
    }
    var numberOfRowsInSection: Int {
        reminderModel.count
    }
//    func cellForItem(at indexPath: IndexPath) -> ReminderList? {
//        reminderModel.count > indexPath.row ? reminderModel[indexPath.row] : nil
//    }
    func didSelectForRow(at index: Int) {
        let viewModel = HomeListViewModel(lists: reminderModel[index])
        view?.navigate(with: .detail(viewModel: viewModel))
    }
    func didTappedNewReminderButton() {
        view?.navigate(with: .addNewReminder)
    }
}

