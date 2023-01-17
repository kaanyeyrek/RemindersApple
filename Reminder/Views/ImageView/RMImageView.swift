//
//  RMImageView.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/15/23.
//

import UIKit

class RMImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    convenience init(setImage: UIImage?, setBackgroundColor: UIColor?) {
        self.init(frame: .zero)
        image = setImage
        backgroundColor = setBackgroundColor
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        layer.cornerRadius = 18
        clipsToBounds = true
        layer.masksToBounds = true
        tintColor = .white
    }
}
