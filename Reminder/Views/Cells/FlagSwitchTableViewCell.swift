//
//  FlagSwitchTableViewCell.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/20/23.
//

import UIKit

protocol FlagSwitchedDelegate {
    func switchedFlag(with: Bool)
}

class FlagSwitchTableViewCell: UITableViewCell {
    
    var delegate: FlagSwitchedDelegate!
    private let flagSwitch = UISwitch()
    private let flagImage = RMImageView(setImage: UIImage(systemName: Constants.flagImage), setBackgroundColor: .orange)
    private let flagLabel = RMLabel(color: .black, alignment: .left, fontSize: 15)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
        setLayout()
        setTarget()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setSubviews() {
        [flagSwitch, flagImage, flagLabel].forEach({ elements in
            self.addSubview(elements)
        })
    }
    private func setLayout() {
        flagSwitch.anchor(top: self.topAnchor, leading: nil, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 15), size: .init(width: 50, height: 50))
        flagSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 30).isActive = true
        
        flagImage.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: .init(top: 10, left: 20, bottom: 10, right: 0), size: .init(width: 30, height: 30))
        flagImage.layer.cornerRadius = 8
        flagImage.contentMode = .center
        flagLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: .init(top: 10, left: 60, bottom: 10, right: 0), size: .init(width: 50, height: 30))
        flagLabel.text = "Flag"
    }
    private func setTarget() {
        flagSwitch.addTarget(self, action: #selector(didChangedSwitchButton), for: .valueChanged)
    }
    @objc private func didChangedSwitchButton() {
        delegate.switchedFlag(with: flagSwitch.isOn)
    }
}
