//
//  PriorityTableViewCell.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/21/23.
//

import UIKit

class PriorityTableViewCell: UITableViewCell {

    private let listLabel = RMLabel(color: .black, alignment: .left, fontSize: 15)
    private let listCategoryLabel = RMLabel(color: .lightGray, alignment: .center, fontSize: 15)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setSubviews() {
        [listLabel, listCategoryLabel].forEach({ elements in
            self.addSubview(elements)
        })
    }
    private func setLayout() {
        listLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 10), size: .init(width: 50, height: 50))
        listLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        listLabel.text = "Priority"
        listCategoryLabel.anchor(top: self.topAnchor, leading: nil, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 15), size: .init(width: 80, height: 50))
    }
    func configure(priorityName: String) {
        listCategoryLabel.text = priorityName
    }

}
