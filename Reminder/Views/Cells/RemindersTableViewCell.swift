//
//  RemindersTableViewCell.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/16/23.
//

import UIKit

protocol ReminderTableViewCellInterface: AnyObject {
    func setTitle(with model: ReminderList)
    func setIcon(with model: ReminderList)
    func setIconBackgroundColor(with model: ReminderList)
    func layout()
    func setUI()
    func addSubviews()
}

class RemindersTableViewCell: UITableViewCell {
    
    private var iconBackground = RMView(color: nil, radius: 33, message: "")
    private var iconImage = RMImageView(setImage: UIImage(systemName: Constants.cellIcon), setBackgroundColor: nil)
    private var remindersTitle = RMLabel(color: .black, alignment: .left, fontSize: 15)
    private var countLabel = RMLabel(color: .lightGray, alignment: .center, fontSize: 20)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        layout()
        setUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - ReminderTableViewCell Interface
extension RemindersTableViewCell: ReminderTableViewCellInterface {
    func addSubviews() {
        [iconBackground, iconImage, remindersTitle ,countLabel].forEach { elements in
            self.addSubview(elements)
        }
    }
    func setUI() {
        remindersTitle.font = .systemFont(ofSize: 15, weight: .medium)
    }
    func layout() {
        iconBackground.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 10, right: 0), size: .init(width: 70, height: 70))
        
        iconImage.anchor(top: iconBackground.topAnchor, leading: iconBackground.leadingAnchor, bottom: iconBackground.bottomAnchor, trailing: iconBackground.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 40, height: 40))
        iconImage.contentMode = .scaleAspectFit
        
        remindersTitle.anchor(top: self.topAnchor, leading: iconBackground.trailingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 15, right: 10), size: .init(width: 80, height: 30))
      
        countLabel.anchor(top: self.topAnchor, leading: nil, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 30), size: .init(width: 30, height: 30))
        countLabel.text = "3"
    }
    public func setTitle(with model: ReminderList) {
        remindersTitle.text = model.title?.capitalized
    }
    public func setIcon(with model: ReminderList) {
        iconImage.image = UIImage(systemName: model.image!)
    }
    public func setIconBackgroundColor(with model: ReminderList) {
        iconImage.backgroundColor = UIColor(hex: model.color!)
    }
}
                   
