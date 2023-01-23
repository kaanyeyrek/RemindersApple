//
//  NewReminderViewController.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/19/23.
//

import UIKit

protocol NewReminderViewInterface: AnyObject {
    func setUI()
    func setNavbar()
    func setSubviews()
    func setLayout()
    func configureTable()
    func createPicker(with picker: UIPickerView)
    func reloadTable()
    func handleOutput(output: ListOutput)
    func setToolBar()
    func popToRootHome()
    func setAlert()
    var titleReminder: String? { get }
    var noteReminder: String? { get }
    var flagBool: Bool? { get }
    var selectedList: String? { get}
    var selectedPriority: String? { get }
    var reminderID: UUID { get }
}

final class NewReminderViewController: UIViewController {
//MARK: - Injections
    private lazy var viewModel: NewReminderViewModelInterface = NewReminderViewModel(view: self)
//MARK: - UI Elements
    private let table = UITableView(frame: .zero, style: .insetGrouped)
    private let toolBarLabel = RMLabel(color: .black, alignment: .center, fontSize: 15)
    private let listPicker = UIPickerView()
    private let priorityPicker = UIPickerView()
    private var toolBar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: 100, height: 45))
    private var priorityList = ["None", "Low", "Medium", "High"]
    private var selectedListName = ""
    private var selectedPriorityName = ""
    private var currentPicker: Int?
    private var currentLists = [ReminderListPresentation]()
    private var isFlagged = true
    private var titles: String?
    private var note: String?
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
    @objc private func didTappedCancel() {
        self.popToRootHome()
    }
    @objc private func didTappedAdd() {
        viewModel.didTapAddedButton()
    }
    @objc private func didTappedDoneButton() {
        toolBar.removeFromSuperview()
        listPicker.removeFromSuperview()
        priorityPicker.removeFromSuperview()
        if currentPicker == 1 {
            self.selectedListName = (currentLists[listPicker.selectedRow(inComponent: 0)].title)!
            DispatchQueue.main.async {
                self.reloadTable()
            }
        }
        if currentPicker == 3 {
            self.selectedPriorityName = (priorityList[priorityPicker.selectedRow(inComponent: 0)])
            DispatchQueue.main.async {
                self.reloadTable()
            }
        }
    }
    @objc private func didTappedCancelButton() {
        toolBar.removeFromSuperview()
        listPicker.removeFromSuperview()
        priorityPicker.removeFromSuperview()
    }
}
//MARK: - NewReminderView Interface
extension NewReminderViewController: NewReminderViewInterface {
    func setUI() {
        view.backgroundColor = .systemBackground
        title = "New Reminder"
        selectedPriorityName = "None"
        selectedListName = "None"
        listPicker.delegate = self
        priorityPicker.delegate = self
    }
    func setSubviews() {
        [table].forEach({ elements in
            view.addSubview(elements)
        })
    }
    func reloadTable() {
        table.reloadData()
    }
    func setNavbar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTappedCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(didTappedAdd))
    }
    func setLayout() {
        table.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.width, height: view.frame.height))
        toolBarLabel.frame = CGRect(x: 20, y: 20, width: 100, height: 50)
    }
    func configureTable() {
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(ReminderFieldTableViewCell.self, forCellReuseIdentifier: ReuseID.reminderFieldTableViewCell)
        table.register(RemindersNoteFieldTableViewCell.self, forCellReuseIdentifier: ReuseID.remindersNoteFieldTableViewCell)
        table.register(ReminderListPickerTableViewCell.self, forCellReuseIdentifier: ReuseID.reminderListPickerTableViewCell)
        table.register(FlagSwitchTableViewCell.self, forCellReuseIdentifier: ReuseID.flagSwitchTableViewCell)
        table.register(PriorityTableViewCell.self, forCellReuseIdentifier: ReuseID.priorityTableViewCell)
        table.showsVerticalScrollIndicator = false
    }
    func setAlert() {
        self.alert(message: "Please fill in the all field.", title: "Error!")
    }
    func createPicker(with picker: UIPickerView) {
        picker.backgroundColor = .systemBackground
        picker.contentMode = .center
        picker.autoresizingMask = .flexibleWidth
        picker.frame = CGRect.init(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        view.addSubview(picker)
        setToolBar()
    }
    func setToolBar() {
        toolBar = UIToolbar(frame: .init(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .default
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTappedDoneButton))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTappedCancelButton))
        let labelButton = UIBarButtonItem(customView: toolBarLabel)
        toolBar.setItems([cancelButton, flexibleSpace, labelButton, flexibleSpace, doneButton], animated: false)
        view.addSubview(toolBar)
    }
    func popToRootHome() {
        navigationController?.popToRootViewController(animated: true)
    }
    var titleReminder: String? {
        return titles
    }
    var noteReminder: String? {
        return note
    }
    var flagBool: Bool? {
        return isFlagged
    }
    var selectedList: String? {
        return selectedListName
    }
    var selectedPriority: String? {
        return selectedPriorityName
    }
    var reminderID: UUID {
        return UUID()
    }
}
//MARK: - UITableView DataSource
extension NewReminderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(with: section)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: ReuseID.reminderFieldTableViewCell, for: indexPath) as! ReminderFieldTableViewCell
                cell.contentView.isUserInteractionEnabled = false
                cell.selectionStyle = .none
                cell.delegate = self
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: ReuseID.remindersNoteFieldTableViewCell, for: indexPath) as! RemindersNoteFieldTableViewCell
                cell.contentView.isUserInteractionEnabled = false
                cell.delegate = self
                cell.selectionStyle = .none
            return cell
        }
      }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseID.reminderListPickerTableViewCell, for: indexPath) as! ReminderListPickerTableViewCell
            cell.contentView.isUserInteractionEnabled = false
            cell.accessoryType = .disclosureIndicator
            cell.configure(listName: selectedListName)
            return cell
        }
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseID.flagSwitchTableViewCell, for: indexPath) as! FlagSwitchTableViewCell
            cell.selectionStyle = .none
            cell.delegate = self
            cell.contentView.isUserInteractionEnabled = false
            return cell
        }
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseID.priorityTableViewCell, for: indexPath) as! PriorityTableViewCell
            cell.accessoryType = .disclosureIndicator
            cell.contentView.isUserInteractionEnabled = false
            cell.configure(priorityName: selectedPriorityName)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        }
    }
    func handleOutput(output: ListOutput) {
        switch output {
        case .listPresentation(let presentation):
            self.currentLists = presentation
            self.reloadTable()
        }
    }
}
//MARK: - UITableView Delegate
extension NewReminderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            currentPicker = 1
            toolBarLabel.text = "List"
            createPicker(with: listPicker)
        }
        else if indexPath.section == 3 {
            currentPicker = 3
            createPicker(with: priorityPicker)
            toolBarLabel.text = "Priority"
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.heightForRowAt(with: indexPath)
    }
}
//MARK: - UIPickerViewDelegate
extension NewReminderViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == listPicker {
            return currentLists[row].title
        } else {
            return priorityList[row]
        }
    }
}
//MARK: - UIPickerViewDataSource
extension NewReminderViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        viewModel.numberOfPickerComponents
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == listPicker {
            return viewModel.numberOfRowsInComponent
        } else {
            return priorityList.count
        }
    }
}
//MARK: - Reminder FlagSwitched Delegate
extension NewReminderViewController: FlagSwitchedDelegate {
    func switchedFlag(with: Bool) {
        isFlagged = with
    }
}
//MARK: - Reminder NoteTextView Delegate
extension NewReminderViewController: ReminderNoteDelegate {
    func reminderNote(with: String) {
        note = with
    }
}
//MARK: - Reminder TitleField Delegate
extension NewReminderViewController: ReminderTitleDelegate {
    func reminderTitle(with: String) {
        titles = with
    }
}
