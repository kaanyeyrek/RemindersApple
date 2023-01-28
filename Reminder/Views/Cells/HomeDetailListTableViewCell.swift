//
//  HomeDetailListTableViewCell.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/25/23.
//

import UIKit

protocol HomeDetailListTableInterface: AnyObject {
    var editingTitle: String { get }
}

class HomeDetailListTableViewCell: UITableViewCell {
    
//MARK: - UI Elements
    private var ID: String?
    private var listTextView = RMTextView()
    private var priorityLabel = RMLabel(color: .orange, alignment: .center, fontSize: 20)
    private var flagIconImage = RMImageView(setImage: UIImage(systemName: Constants.flaggedIcon), setBackgroundColor: .orange)
    private var selectionList = RMImageView(setImage: UIImage(systemName: Constants.circleImage), setBackgroundColor: .none)
    private var editingTextField = ""
    
//MARK: - Injections
    private lazy var viewModel: HomeDetailListViewModelInterface = HomeDetailListViewModel(view: self)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewModel.viewDidLoad()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: - @objc action
    @objc private func didTappedCompletedList() {
        selectionList.backgroundColor = .systemGreen
    }
    func setUI() {
        selectionList.layer.cornerRadius = self.frame.height / 2
        flagIconImage.layer.cornerRadius = self.frame.height / 2
        flagIconImage.contentMode = .center
        selectionList.layer.borderColor = UIColor.black.cgColor
        selectionList.layer.borderWidth = 1
        listTextView.isScrollEnabled = true
        listTextView.backgroundColor = .clear
        listTextView.font = .boldSystemFont(ofSize: 15)
        listTextView.textColor = .black
        listTextView.delegate = self
    }
    func setGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTappedCompletedList))
        self.addGestureRecognizer(gesture)
    }
    func setAddSubviews() {
        [listTextView, flagIconImage, selectionList, priorityLabel].forEach { elements in
            self.addSubview(elements)
        }
    }
    func setLayout() {
        selectionList.anchor(top: nil, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0), size: .init(width: 45, height: 45))
        selectionList.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        priorityLabel.anchor(top: nil, leading: selectionList.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 40, height: 45))
        priorityLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        listTextView.anchor(top: nil, leading: priorityLabel.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 250, height: 50))
        listTextView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 5).isActive = true
        
        flagIconImage.anchor(top: nil, leading: nil, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 10), size: .init(width: 45, height: 45))
        flagIconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    func setPriority(model: ReminderPresentation) {
        if model.remindPriority == "None" {
            priorityLabel.text = ""
        } else if model.remindPriority == "Low" {
            priorityLabel.text = "!"
        } else if model.remindPriority == "Medium" {
            priorityLabel.text = "!!"
        } else if model.remindPriority == "High" {
            priorityLabel.text = "!!!"
        }
    }
    func setFlagIcon(model: ReminderPresentation) {
        if model.remindFlagged == true {
            flagIconImage.isHidden = false
       } else {
           flagIconImage.isHidden = true
       }
    }
    func setTitle(model: ReminderPresentation) {
        listTextView.text =  model.remindTitle
    }
    func setID(model: ReminderPresentation) {
        self.ID = model.remindID
    }
}
//MARK: - UITextView Delegate
extension HomeDetailListTableViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text == "\n" else { return true }
        textView.resignFirstResponder()
        return false
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        editingTextField = textView.text
        viewModel.savedEditReminderTitle(reminderID: self.ID ?? "")
    }
}
//MARK: - HomeDetailListTable Interface
extension HomeDetailListTableViewCell: HomeDetailListTableInterface {
    var editingTitle: String {
        editingTextField
    }
}
