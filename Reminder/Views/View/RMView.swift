//
//  RMView.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/15/23.
//

import UIKit

class RMView: UIView {
    
    let label = RMLabel(color: .black, alignment: .center, fontSize: 20)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    convenience init(color: UIColor?, radius: CGFloat, message: String?) {
        self.init(frame: .zero)
        backgroundColor = color
        layer.cornerRadius = radius
        label.text = message
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        backgroundColor = .systemBackground
        layer.masksToBounds = true
        clipsToBounds = true
        addSubview(label)
        label.textColor = .secondaryLabel
        label.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 100, height: 200))
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
