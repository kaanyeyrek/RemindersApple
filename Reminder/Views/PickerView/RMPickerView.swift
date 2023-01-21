//
//  RMPickerView.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/21/23.
//

import UIKit

class RMPickerView: UIPickerView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        backgroundColor = .systemBackground
        autoresizingMask = .flexibleWidth
        contentMode = .center
    }
}
