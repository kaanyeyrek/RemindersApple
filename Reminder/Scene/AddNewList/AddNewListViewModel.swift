//
//  AddNewListViewModel.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/16/23.
//

import Foundation

protocol AddNewListViewModelInterface {
    func viewDidLoad()
    func viewWillAppear()
    func didTappedAdd()
}

final class AddNewListViewModelController {
    private weak var view: AddNewListViewInterface?
    private var manager: CoreDataManagerInterface
    
    init(view: AddNewListViewInterface, manager: CoreDataManagerInterface = CoreDataManager()) {
        self.view = view
        self.manager = manager
    }
}
//MARK: - AddNewListViewModel Interface
extension AddNewListViewModelController: AddNewListViewModelInterface {
    func viewWillAppear() {
        view?.setNavItem()
    }
    func viewDidLoad() {
        view?.setUI()
        view?.setSubviews()
        view?.setCollection()
        view?.setLayout()
    }
    func didTappedAdd() {
        if let title = view?.listTitle, !title.isEmpty,
           let listColor = view?.listColor, !listColor.isEmpty,
           let listIcon = view?.listIcon, !listIcon.isEmpty
        {
            guard let context = CoreDataManager().context else { return }
            let newList = ReminderList(context: context)
            newList.image = listIcon
            newList.color = listColor
            newList.title = title
            CoreDataManager().save()
            view?.popToHomeVC()
        } else {
            view?.showAlert()
        }
    }
}
