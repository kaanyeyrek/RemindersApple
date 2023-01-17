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
}

final class AddNewListViewModelController {
    private weak var view: AddNewListViewInterface?
    
    init(view: AddNewListViewInterface) {
        self.view = view
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
}
