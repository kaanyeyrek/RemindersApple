//
//  DetailBuilder.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/19/23.
//

import Foundation

final class DetailBuilder {
    static func make(viewModel: HomeListViewModelInterface) -> HomeListViewController {
        let vc = HomeListViewController(viewModel: viewModel)
        return vc
    }
}
