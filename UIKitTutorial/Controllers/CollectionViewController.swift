//
//  CollectionViewController.swift
//  UIKitTutorial
//
//  Created by Priyatam on 07/12/25.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	private var collectionView: UICollectionView
	private var users: [User] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Collection View"
		view.backgroundColor = .systemBackground
		
		setupCollectionView()
		getUsers()
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = 16
		layout.minimumInteritemSpacing = 16
		
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func getUsers() {
		NetworkManager.shared.fetchUsers { [weak self] users in
			guard let self else { return }
			
			self.users = users
			
			// Perform UI update on main thread
			DispatchQueue.main.async {
				self.collectionView.reloadData()
			}
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return users.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCollectionViewCell.reuse, for: indexPath) as? UserCollectionViewCell else { return UICollectionViewCell() }
		cell.configure(with: users[indexPath.row])
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let size = collectionView.frame.width / 2 - 12
		
		return CGSize(width: size, height: size)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print("Item pressed: \(indexPath.item)")
	}
	
	private func setupCollectionView() {
		collectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: UserCollectionViewCell.reuse)
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(collectionView)
		
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6),
			collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
		])
	}
}
