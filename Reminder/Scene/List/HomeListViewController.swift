//
//  HomeListViewController.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/19/23.
//

import UIKit

protocol HomeListViewInterface: AnyObject {
    func setUI()
    func setSubviews()
    func setTableConfigure()
    func setLayout()
    func setRegisterTable()
    func setHandlePresentation(output: HomeListOutput)
    func tableReload()
    func setTitle(model: ReminderList)
    func setNavBarTitleColor(model: ReminderList)
}

final class HomeListViewController: UIViewController {
//MARK: - Injections
    private var viewModel: HomeListViewModelInterface!
    
    init(viewModel: HomeListViewModelInterface!) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: - UI Elements
    private let table = UITableView()
    private var remindPresentation = [ReminderPresentation]()
//MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    func setTableConfigure() {
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .singleLine
        table.separatorInset = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0)
        table.showsVerticalScrollIndicator = false
    }
}
//MARK: - HomeListView Interface
extension HomeListViewController: HomeListViewInterface {
    func setUI() {
        view.backgroundColor = .systemBackground
    }
    func setSubviews() {
        [table].forEach { elements in
            view.addSubview(elements)
        }
    }
    func setLayout() {
        table.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.width, height: view.frame.height))
    }
    func setRegisterTable() {
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    func tableReload() {
        table.reloadData()
    }
    func setTitle(model: ReminderList) {
        title = model.title?.capitalized
    }
    func setNavBarTitleColor(model: ReminderList) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(hex: model.color ?? "")!]
    }
    func setHandlePresentation(output: HomeListOutput) {
        switch output {
        case .loadRemindPresentation(let presentation):
            self.remindPresentation = presentation
            self.tableReload()
        case .showEmptyView(let message):
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, at: self.view)
            }
        case .removeEmpty:
            self.removeEmptyStateView()
        }
    }
}
//MARK: - UITableViewDataSource
extension HomeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRow
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let model = remindPresentation[indexPath.row]
        cell.textLabel?.text = model.remindTitle
        return cell
    }
}
//MARK: - UITableViewDelegate
extension HomeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.heightForRowAt(at: indexPath)
    }
}
