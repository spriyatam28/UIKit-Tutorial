//
//  BirdTableViewCell.swift
//  UIKitTutorial
//
//  Created by Priyatam on 05/12/25.
//

import UIKit

class BBTableViewCell: UITableViewCell {
	// MARK: - Properties (views)
	
	private let userId = UILabel()
	private let postTitle = UILabel()
	private let postBody = UILabel()
	
	static let reuse = "PostsTableViewCellReuse"
	
	// MARK: - init
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		setupUI()
	}
	
	override func setEditing(_ editing: Bool, animated: Bool) {
		super.setEditing(editing, animated: animated)
		self.showsReorderControl = editing
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Configure
	
	func configure(with post: Post) {
		userId.text = String(post.userId)
		postTitle.text = post.title
		postBody.text = post.body
	}
	
	// MARK: - Setup UI
	
	private func setupUI() {
		// MARK: - Setup birdImage
		userId.textColor = .label
		userId.textAlignment = .left
		userId.font = .systemFont(ofSize: 16, weight: .regular)
		userId.translatesAutoresizingMaskIntoConstraints = false
		
		contentView.addSubview(userId)
		
		// MARK: - Setup birdLabel
		postTitle.textColor = .label
		postTitle.textAlignment = .center
		postTitle.font = .systemFont(ofSize: 16, weight: .medium)
		postTitle.translatesAutoresizingMaskIntoConstraints = false
		
		contentView.addSubview(postTitle)
		
		postBody.textColor = .label
		postBody.adjustsFontSizeToFitWidth = true
		postBody.textAlignment = .center
		postBody.numberOfLines = 0
		postBody.lineBreakMode = .byWordWrapping
		postBody.font = .systemFont(ofSize: 16, weight: .regular)
		postBody.translatesAutoresizingMaskIntoConstraints = false
		
		contentView.addSubview(postBody)
		
		NSLayoutConstraint.activate([
			userId.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
			userId.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
			userId.widthAnchor.constraint(equalToConstant: 32),
			
			postTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
			postTitle.leadingAnchor.constraint(equalTo: userId.trailingAnchor, constant: 6),
			postTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
			
			postBody.topAnchor.constraint(equalTo: userId.bottomAnchor, constant: 12),
			postBody.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
			postBody.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			postBody.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
		])
	}
}
