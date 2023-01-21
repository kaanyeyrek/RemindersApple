//
//  RemindersNoteFieldTableViewCell.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/19/23.
//

import UIKit

protocol ReminderNoteDelegate {
    func reminderNote(with: String)
}

class RemindersNoteFieldTableViewCell: UITableViewCell {

    var delegate: ReminderNoteDelegate!
    private let reminderNoteTextView = RMTextView()
    private let placeHolder = "Notes"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
        setLayout()
        reminderNoteTextView.delegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setSubviews() {
        [reminderNoteTextView].forEach({ elements in
            self.addSubview(elements)
        })
    }
    private func setLayout() {
        reminderNoteTextView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 0, left: 13, bottom: 0, right: 10), size: .init(width: 100, height: 70))
        reminderNoteTextView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -15).isActive = true
        reminderNoteTextView.backgroundColor = .systemBackground
        reminderNoteTextView.text = placeHolder
        reminderNoteTextView.textColor = .lightGray
    }
}
//MARK: - UITextView Delegate
extension RemindersNoteFieldTableViewCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = placeHolder
            textView.textColor = .lightGray
        } else {
            delegate.reminderNote(with: textView.text)
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text == "\n" else { return true }
        textView.resignFirstResponder()
        return false
    }
}


