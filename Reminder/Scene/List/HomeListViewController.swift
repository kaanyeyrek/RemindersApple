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
}
//MARK: - UITableViewDataSource
extension HomeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRow
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let model = viewModel.cellForRow(at: indexPath) else { return cell }
        cell.textLabel?.text = model.title
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
