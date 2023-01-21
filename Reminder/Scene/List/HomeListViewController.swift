//
//  HomeListViewController.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/19/23.
//

import UIKit
import CoreData

protocol HomeListViewInterface: AnyObject {
    func setUI()
    func setSubviews()
}

final class HomeListViewController: UIViewController {
//MARK: - Injections
    private lazy var viewModel: HomeListViewModelInterface = HomeListViewModel(view: self)
//MARK: - UI Components
    var listModel: ReminderList?
//MARK: - UI Elements
    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}
//MARK: - HomeListView Interface
extension HomeListViewController: HomeListViewInterface {
    func setUI() {
        view.backgroundColor = .systemBackground
    }
    func setSubviews() {
    }
}
