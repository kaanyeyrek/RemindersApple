//
//  ViewController.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/14/23.
//

import UIKit

protocol HomeViewInterface: AnyObject {
    func setUI()
    func setAddSubviews()
    func setLayout()
    func setSearchController()
    func setTableView()
}

final class HomeViewController: UIViewController {
//MARK: - Injections
    private lazy var viewModel: HomeViewModelInterface = HomeViewModel(view: self)
//MARK: - UI Elements
    private let table = UITableView()
    private let tableHeaderTitle = RMLabel(color: .black, alignment: .left, fontSize: 30)
    private var searchController = UISearchController()
    private var allView = RMView()
    private var flaggedView = RMView()
    private var allLabel = RMLabel(color: .lightGray, alignment: .left, fontSize: 20)
    private var flaggedLabel = RMLabel(color: .lightGray, alignment: .left, fontSize: 20)
    private var allCountLabel = RMLabel(color: .black, alignment: .center, fontSize: 30)
    private var flaggedCountLabel = RMLabel(color: .black, alignment: .center, fontSize: 30)
    private var allIcon = RMImageView(setImage: UIImage(systemName: Constants.allIcon)!, setBackgroundColor: .darkGray)
    private var flaggedIcon = RMImageView(setImage: UIImage(systemName: Constants.flaggedIcon)!, setBackgroundColor: .systemOrange)
    private var newReminderButton = RMButton(title: " New Reminder", titleColor: .link, image: UIImage(systemName: Constants.addNewReminder)!, size: 20)
    private var addListButton = RMButton(title: "Add List", titleColor: .link, image: nil, size: 17)
//MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
//MARK: - @objc actions
    
}
//MARK: - HomeViewInterface Methods
extension HomeViewController: HomeViewInterface {
    func setUI() {
        view.backgroundColor = .systemGroupedBackground
        allLabel.text = "All"
        flaggedLabel.text = "Flagged"
        tableHeaderTitle.text = "My Lists"
        table.layer.cornerRadius = 20
    }
    func setAddSubviews() {
      [tableHeaderTitle, allView, flaggedView, allLabel, flaggedLabel, allCountLabel, flaggedCountLabel, allIcon, flaggedIcon, table, newReminderButton, addListButton].forEach { elements in
            view.addSubview(elements)
        }
    }
    func setLayout() {
        allView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 5, left: 20, bottom: 5, right: 0), size: .init(width: 180, height: 120))
        allView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -240).isActive = true
   
        flaggedView.anchor(top: view.topAnchor, leading: allView.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 5, left: 20, bottom: 5, right: 20), size: .init(width: 180, height: 120))
        flaggedView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -240).isActive = true
       
        allLabel.anchor(top: allView.topAnchor, leading: allView.leadingAnchor, bottom: allView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 5, right: 0), size: .init(width: 50, height: 30))
        
        flaggedLabel.anchor(top: flaggedView.topAnchor, leading: flaggedView.leadingAnchor, bottom: flaggedView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 5, right: 0), size: .init(width: 80, height: 30))
        
        allCountLabel.anchor(top: allView.topAnchor, leading: nil, bottom: nil, trailing: allView.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 5), size: .init(width: 50, height: 30))
        allCountLabel.text = "10"
        
        flaggedCountLabel.anchor(top: flaggedView.topAnchor, leading: nil, bottom: nil, trailing: flaggedView.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 5), size: .init(width: 50, height: 30))
        flaggedCountLabel.text = "1"
        
        allIcon.anchor(top: allView.topAnchor, leading: allView.leadingAnchor, bottom: allLabel.topAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 35, right: 0), size: .init(width: 40, height: 40))
        
        flaggedIcon.anchor(top: flaggedView.topAnchor, leading: flaggedView.leadingAnchor, bottom: flaggedLabel.topAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 35, right: 0), size: .init(width: 40, height: 40))
        
        table.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20), size: .init(width: 200, height: 450))
        table.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 120).isActive = true
        
        tableHeaderTitle.anchor(top: allView.bottomAnchor, leading: view.leadingAnchor, bottom: table.topAnchor, trailing: nil, padding: .init(top: 0, left: 25, bottom: 10, right: 0), size: .init(width: 120, height: 40))
        
        newReminderButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 35, right: 0), size: .init(width: 170, height: 50))
        
        addListButton.anchor(top: nil, leading: nil, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 35, right: 10), size: .init(width: 80, height: 50))
    }
    func setSearchController() {
        searchController.delegate = self
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    func setTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.separatorStyle = .singleLine
        table.separatorInset = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0)
        table.showsVerticalScrollIndicator = false
    }
}
//MARK: - UITableView Datasource Methods
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Reminders"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
//MARK: - UITableView Delegate Methods
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .init(50)
    }
}
//MARK: - UISearchControllerDelegate Methods
extension HomeViewController: UISearchControllerDelegate {
    
}

