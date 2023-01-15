//
//  RMButton.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/15/23.
//

import UIKit

class RMButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    convenience init(title: String, titleColor: UIColor, image: UIImage?, size: CGFloat) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        setImage(image, for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: size)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }
}
