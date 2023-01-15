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
}

final class HomeViewModel {
    private weak var view: HomeViewInterface?
    
    init(view: HomeViewInterface) {
        self.view = view
    }
}
//MARK: - HomeViewModelInterface Methods
extension HomeViewModel: HomeViewModelInterface {
    func viewWillAppear() {
    }
    func viewDidLoad() {
        view?.setUI()
        view?.setAddSubviews()
        view?.setLayout()
        view?.setSearchController()
        view?.setTableView()
    }
}

