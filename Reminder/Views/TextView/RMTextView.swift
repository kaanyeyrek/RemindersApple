//
//  RMTextView.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/20/23.
//

import UIKit

class RMTextView: UITextView {
    
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        textColor = .lightGray
        font = .systemFont(ofSize: 17, weight: .regular)
        autocapitalizationType = .none
    }
}

