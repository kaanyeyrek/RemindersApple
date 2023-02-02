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
    func navigate(route: HomeListRoute)
    func setTarget()
}

final class HomeListViewController: UIViewController {
//MARK: - Injections
    private var viewModel: HomeListViewModelInterface!
    private var newReminderButton = RMButton(title: " New Reminder", titleColor: .orange, image: UIImage(systemName: Constants.addNewReminder), size: 20)
    
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
    //MARK: - @objc actions
    @objc private func didTappedNewReminder() {
        viewModel.newReminderButton()
    }
}
//MARK: - HomeListView Interface
extension HomeListViewController: HomeListViewInterface {
    func setUI() {
        view.backgroundColor = .systemBackground
        newReminderButton.tintColor = .orange
    }
    func setSubviews() {
        [table, newReminderButton].forEach { elements in
            view.addSubview(elements)
        }
    }
    func setTarget() {
        newReminderButton.addTarget(self, action: #selector(didTappedNewReminder), for: .touchUpInside)
    }
    func setLayout() {
        table.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.width, height: view.frame.height))
        
        newReminderButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 35, right: 0), size: .init(width: 170, height: 50))
    }
    func setRegisterTable() {
        table.register(HomeDetailListTableViewCell.self, forCellReuseIdentifier: ReuseID.homeDetailListTableViewCell)
    }
    func tableReload() {
        table.reloadData()
    }
    func setTableConfigure() {
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .singleLine
        table.separatorInset = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0)
        table.showsVerticalScrollIndicator = false
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
    func navigate(route: HomeListRoute) {
        switch route {
        case .newReminder:
            let vc = NewReminderViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
//MARK: - UITableViewDataSource
extension HomeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRow
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseID.homeDetailListTableViewCell, for: indexPath) as! HomeDetailListTableViewCell
        cell.contentView.isUserInteractionEnabled = false
        let model = remindPresentation[indexPath.row]
        cell.setTitle(model: model)
        cell.setFlagIcon(model: model)
        cell.setPriority(model: model)
        cell.setID(model: model)
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deletedRemind(indexPath: indexPath)
        }
    }
}
//MARK: - UITableViewDelegate
extension HomeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.deletedRemind(indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.heightForRowAt(at: indexPath)
    }
}
