//
//  RMView.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/15/23.
//

import UIKit

class RMView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    convenience init(color: UIColor?, radius: CGFloat) {
        self.init(frame: .zero)
        backgroundColor = color
        layer.cornerRadius = radius
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        backgroundColor = .systemBackground
       
    }
}
