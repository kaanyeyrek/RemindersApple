//
//  AddNewListViewController.swift
//  Reminder
//
//  Created by Kaan Yeyrek on 1/16/23.
//

import UIKit

protocol AddNewListViewInterface: AnyObject {
    func setUI()
    func setSubviews()
    func setNavItem()
    func setCollection()
    func setLayout()
    func showAlert()
    func popToHomeVC()
    func endKeyboard()
    func setTarget()
    var listColor: String? { get }
    var listIcon: String? { get }
    var listTitle: String? { get }
}

final class AddNewListViewController: UIViewController {
//MARK: - Injections
    private lazy var viewModel: AddNewListViewModelInterface = AddNewListViewModelController(view: self)
    private let newListIcon = RMImageView(setImage: UIImage(systemName: ListIcon.bookmark), setBackgroundColor: .link)
    private let newListField = RMTextField(alignment: .center, setPlaceHolder: "Add new list title..")
//MARK: - UI Elements
    private var collection: UICollectionView!
//MARK: - UI Components
    private var listArray = ["#e93b81ff", "#9fe6a0ff", "#233e8bff", "#e40017ff", "#ff5200ff", "#295939ff", "#231939ff", "#371A54ff", "#DB5314ff", "#DB15BBff", "#5EA2DBff", "#5EA290ff", ListIcon.list, ListIcon.bookmark, ListIcon.house, ListIcon.gift, ListIcon.birthday, ListIcon.airplane]
//MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
//MARK: - @objc actions
    @objc private func didTappedAddButton() {
        viewModel.didTappedAdd()
    }
    @objc private func didTappedCancelButton() {
        navigationController?.popToRootViewController(animated: true)
    }
    @objc private func didTappedEmptyForCloseKeyboard() {
        self.view.endEditing(true)
    }
    @objc private func didChangeEnabledAddButton() {
        if newListField.text == "" {
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
}
//MARK: - AddNewListViewInterface Interface
extension AddNewListViewController: AddNewListViewInterface {
    func setUI() {
        title = "New List"
        view.backgroundColor = .systemBackground
    }
    func setSubviews() {
        [newListIcon, newListField].forEach { elements in
            view.addSubview(elements)
        }
    }
    func setTarget() {
        newListField.addTarget(self, action: #selector(didChangeEnabledAddButton), for: .editingChanged)
    }
    func setNavItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(didTappedAddButton))
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTappedCancelButton))
    }
    func setCollection() {
        let layout = UICollectionViewFlowLayout()
        collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collection = collection else { return }
        collection.delegate = self
        collection.dataSource = self
        view.addSubview(collection)
        collection.register(NewListCollectionViewCell.self, forCellWithReuseIdentifier: ReuseID.newListCollectionCell)
    }
    func setLayout() {
        collection.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.width, height: 400))
        collection.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 170).isActive = true
        
        newListIcon.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: 70, height: 70))
        newListIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newListIcon.contentMode = .scaleAspectFit
        newListIcon.layer.cornerRadius = 33
        
        newListField.anchor(top: newListIcon.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 120, right: 20), size: .init(width: 100, height: 50))
        newListField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -210).isActive = true
        newListField.layer.borderWidth = 0.5
    }
    var listColor: String? {
        savedAttributes.thumbnailColor
    }
    var listIcon: String? {
        savedAttributes.thumbNailImage
    }
    var listTitle: String? {
        newListField.text
    }
    func popToHomeVC() {
        navigationController?.popToRootViewController(animated: true)
    }
    func showAlert() {
        self.alert(message: "Please fill in the all field.", title: "Error!")
    }
    func endKeyboard() {
       let gesture = UITapGestureRecognizer(target: self, action: #selector(didTappedEmptyForCloseKeyboard))
        gesture.view?.isUserInteractionEnabled = true
        gesture.delegate = self
        view.addGestureRecognizer(gesture)
    }
}
//MARK: - UICollectionView Datasource
extension AddNewListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collection.dequeueReusableCell(withReuseIdentifier: ReuseID.newListCollectionCell, for: indexPath) as? NewListCollectionViewCell else { return UICollectionViewCell() }
        if indexPath.item > 11 {
            cell.circleImageView.tintColor = .darkGray
            cell.circleImageView.image = UIImage(systemName: listArray[indexPath.item])
        } else {
            cell.circleImageView.backgroundColor = UIColor(hex: listArray[indexPath.item])
        }
        return cell
    }
}
//MARK: - UICollectionView Delegate
extension AddNewListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item > 11 {
            savedAttributes.thumbNailImage = listArray[indexPath.item]
            newListIcon.image = UIImage(systemName: listArray[indexPath.item])
            
        } else {
            savedAttributes.thumbnailColor = listArray[indexPath.item]
            newListIcon.backgroundColor = UIColor(hex: listArray[indexPath.item])
        }
    }
}
//MARK: - UICollection DelegateFlowLayout Methods
extension AddNewListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 20, bottom: 0, right: 20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
}
//MARK: - UIGestureRecognizerDelegate Methods
extension AddNewListViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if view.frame.contains(touch.location(in: collection)) {
            return false
        }
        return true
    }
}
