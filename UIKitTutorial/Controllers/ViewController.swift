//
//  ViewController.swift
//  UIKitTutorial
//
//  Created by Priyatam on 05/12/25.
//

import UIKit

class ViewController: UIViewController {
	private let tableView = UITableView()
	private var bossBabies: [BossBaby] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Boss Babies"
		view.backgroundColor = .systemBackground
		navigationItem.leftBarButtonItem = UIBarButtonItem(
			image: UIImage(systemName: "globe"),
			style: .plain,
			target: self,
			action: #selector(changeLanguage)
		)
		navigationItem.leftBarButtonItem?.tintColor = .systemCyan
		navigationItem.rightBarButtonItem = editButtonItem
		
		populateBossBabies()
		setupTableView()
	}
	
	override func setEditing(_ editing: Bool, animated: Bool) {
		super.setEditing(editing, animated: animated)
		tableView.setEditing(editing, animated: animated)
	}
	
	@objc
	private func changeLanguage() {
		//TODO: - Implement language change
	}
	
	private func populateBossBabies() {
		let name: String = "Boss Baby"
		let imageName: String = "baby"
		
		for i in 1...100 {
			bossBabies.append(BossBaby(name: "\(name) - \(i)", image: imageName))
		}
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

extension ViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 120
	}
}

extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return bossBabies.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: BBTableViewCell.reuse, for: indexPath) as? BBTableViewCell else { return UITableViewCell() }
		
		cell.selectionStyle = .default
		cell.configure(with: bossBabies[indexPath.row])
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedRow = bossBabies[indexPath.row]
		let detailsVC = ShowDetailsVC()
		detailsVC.selectedText = selectedRow.name
		
		navigationController?.pushViewController(detailsVC, animated: true)
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			bossBabies.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
	
	func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		let movedRow = bossBabies.remove(at: sourceIndexPath.row)
		bossBabies.insert(movedRow, at: destinationIndexPath.row)
	}
}
