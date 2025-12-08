//
//  ViewController.swift
//  UIKitTutorial
//
//  Created by Priyatam on 05/12/25.
//

import UIKit

class ViewController: UIViewController {
	// MARK: - UI properties
	private let tableView = UITableView()
	private var posts: [Post]? = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Boss Babies"
		view.backgroundColor = .systemBackground
		navigationItem.leftBarButtonItem = UIBarButtonItem(
			image: UIImage(systemName: "globe"),
			style: .plain,
			target: self,
			action: #selector(goToCollectionView)
		)
		navigationItem.leftBarButtonItem?.tintColor = .systemCyan
		navigationItem.rightBarButtonItem = editButtonItem
		
		do {
			posts = try PostRepository.shared.fetchAll()
			tableView.reloadData()
		} catch {
			print("Error: \(error.localizedDescription)")
		}
		
		getPosts()
		setupTableView()
	}
	
	override func setEditing(_ editing: Bool, animated: Bool) {
		super.setEditing(editing, animated: animated)
		tableView.setEditing(editing, animated: animated)
	}
	
	@objc
	private func getPosts() {
		NetworkManager.shared.fetchPosts { [weak self] posts in
			guard let self else { return }
			
			// Save to DB
			do {
				try PostRepository.shared.insertAll(posts)
				print("successfully inserted all posts into the db")
			} catch {
				print("DB error: \(error.localizedDescription)")
			}
			
			self.posts = posts
			
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
	
	private func showAnimation(named name: String, loop: Bool = false) {
		
	}
	
	@objc
	private func goToCollectionView() {
		let collectionVC = CollectionViewController()
		
		navigationController?.pushViewController(collectionVC, animated: true)
	}
	
	private func setupTableView() {
		tableView.register(BBTableViewCell.self, forCellReuseIdentifier: BBTableViewCell.reuse)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(tableView)
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
		])
	}
}

// MARK: - VC extends ViewTable
extension ViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 180
	}
}

extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return posts?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: BBTableViewCell.reuse, for: indexPath) as? BBTableViewCell else { return UITableViewCell() }
		
		cell.selectionStyle = .default
		cell.configure(with: posts![indexPath.row])
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedRow = posts![indexPath.row]
		let detailsVC = ShowDetailsVC()
		detailsVC.selectedText = selectedRow.title
		
		navigationController?.pushViewController(detailsVC, animated: true)
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			posts!.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
	
	func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		let movedRow = posts!.remove(at: sourceIndexPath.row)
		posts!.insert(movedRow, at: destinationIndexPath.row)
	}
}
