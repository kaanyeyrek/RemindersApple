//
//  RMTextField.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/17/23.
//

import UIKit

class RMTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    convenience init(alignment: NSTextAlignment) {
        self.init(frame: .zero)
        textAlignment = alignment
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        placeholder = "Add New List.."
        autocapitalizationType = .words
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 10
        layer.masksToBounds = true
        font = .systemFont(ofSize: 20, weight: .bold)
    }
}
