//
//  HomeListViewModel.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/19/23.
//

import Foundation

protocol HomeListViewModelInterface {
    func viewDidLoad()
}

final class HomeListViewModel {
    private weak var view: HomeListViewInterface?
    
    init(view: HomeListViewInterface) {
        self.view = view
    }
}
//MARK: - HomeListViewModel Interface
extension HomeListViewModel: HomeListViewModelInterface {
    func viewDidLoad() {
        view?.setUI()
        view?.setSubviews()
    }
}
