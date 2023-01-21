//
//  NewListCollectionViewCell.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/16/23.
//

import UIKit

class NewListCollectionViewCell: UICollectionViewCell {
    
    public var circleImageView = RMImageView(setImage: nil, setBackgroundColor: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addSubviews() {
        [circleImageView].forEach({ elements in
            self.addSubview(elements)
        })
    }
    private func layout() {
        circleImageView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 50, height: 50))
        circleImageView.layer.cornerRadius = 25
    }
}
