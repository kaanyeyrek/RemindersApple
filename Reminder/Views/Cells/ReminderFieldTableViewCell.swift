//
//  ReminderFieldTableViewCell.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/19/23.
//

import UIKit

protocol ReminderTitleDelegate {
    func reminderTitle(with: String)
}

class ReminderFieldTableViewCell: UITableViewCell {
    
    var delegate: ReminderTitleDelegate!
    private let reminderTextField = RMTextField(alignment: .left, setPlaceHolder: "Title")

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
        setLayout()
        reminderTextField.delegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setSubviews() {
        [reminderTextField].forEach({ elements in
            self.addSubview(elements)
        })
    }
    private func setLayout() {
        reminderTextField.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 10, left: 13, bottom: 10, right: 10), size: .init(width: self.frame.width, height: 30))
        reminderTextField.backgroundColor = .systemBackground
        reminderTextField.autocapitalizationType = .none
    }
}
//MARK: - UITextField Delegate
extension ReminderFieldTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.reminderTitle(with: textField.text!)
        reminderTextField.placeholder = "Title"
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == reminderTextField {
            self.endEditing(true)
            return false
        }
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == reminderTextField {
            reminderTextField.placeholder = ""
            return true
        }
        return false
    }
}
