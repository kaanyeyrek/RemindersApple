//
//  RemindersTableViewCell.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/16/23.
//

import UIKit

class RemindersTableViewCell: UITableViewCell {
    
    private var iconBackground = RMView(color: .red, radius: 20)
    private var iconImage = RMImageView(setImage: UIImage(systemName: Constants.cellIcon), setBackgroundColor: nil)
    private var remindersTitle = RMLabel(color: .black, alignment: .left, fontSize: 15)
    private var countLabel = RMLabel(color: .lightGray, alignment: .center, fontSize: 20)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        layout()
        configure()
        setUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addSubviews() {
        [iconBackground, iconImage, remindersTitle ,countLabel].forEach { elements in
            self.addSubview(elements)
        }
    }
    private func setUI() {
        remindersTitle.font = .systemFont(ofSize: 15, weight: .medium)
    }
    private func layout() {
        iconBackground.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 10, right: 0), size: .init(width: 40, height: 40))
        
        iconImage.anchor(top: iconBackground.topAnchor, leading: iconBackground.leadingAnchor, bottom: iconBackground.bottomAnchor, trailing: iconBackground.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 40, height: 40))
        iconImage.contentMode = .center
        
        remindersTitle.anchor(top: self.topAnchor, leading: iconBackground.trailingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 15, right: 10), size: .init(width: 80, height: 30))
        remindersTitle.text = "Reminders"
      
        countLabel.anchor(top: self.topAnchor, leading: nil, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 30), size: .init(width: 30, height: 30))
        countLabel.text = "3"
    }
    private func configure() {
        
    }
}
                   
