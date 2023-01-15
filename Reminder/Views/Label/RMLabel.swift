//
//  RMLabel.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/15/23.
//

import UIKit

class RMLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    convenience init(color: UIColor, alignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        textColor = color
        textAlignment = alignment
        font = .systemFont(ofSize: fontSize, weight: .bold)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        numberOfLines = 0
        
    }
}
