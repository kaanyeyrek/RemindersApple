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
        view?.endKeyboard()
        view?.setTarget()
    }
    func didTappedAdd() {
        if let title = view?.listTitle, !title.isEmpty, !title.contains(" "),
           let listColor = view?.listColor,
           let listIcon = view?.listIcon,
           let id = view?.listID.uuidString
        {
            guard let context = CoreDataManager().context else { return }
            let newList = ReminderList(context: context)
            newList.image = listIcon
            newList.color = listColor
            newList.title = title
            newList.id = id
            CoreDataManager().save()
            view?.popToHomeVC()
        } else {
            view?.showAlert()
        }
    }
}
