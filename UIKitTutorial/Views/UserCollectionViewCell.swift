//
//  BirdCollectionViewCell.swift
//  UIKitTutorial
//
//  Created by Priyatam on 07/12/25.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
	// MARK: - Properties (views)
	private let idLabel = UILabel()
	private let nameLabel = UILabel()
	private let usernameLabel = UILabel()
	private let emailLabel = UILabel()
	private let addressLabel = UILabel()
	private let phoneLabel = UILabel()
	private let websiteLabel = UILabel()
	private let companyLabel = UILabel()
	
	static let reuse = "UserCollectionViewCell"
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Configure Cell
	func configure(with user: User) {
		idLabel.text = "ID: \(user.id)"
		nameLabel.text = "Name: \(user.name)"
		usernameLabel.text = "Username: \(user.username)"
		emailLabel.text = "Email: \(user.email)"
		addressLabel.text = "City: \(user.address.city)"
		phoneLabel.text = "Phone: \(user.phone)"
		websiteLabel.text = "Website: \(user.website)"
		companyLabel.text = "Company: \(user.company.name)"
	}
	
	
	// MARK: - UI Setup
	private func setupUI() {
		// Card background
		contentView.backgroundColor = .systemBackground
		contentView.layer.cornerRadius = 12
		contentView.layer.borderWidth = 1
		contentView.layer.borderColor = UIColor.systemGray5.cgColor
		contentView.layer.shadowOpacity = 0.1
		contentView.layer.shadowRadius = 4
		contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
		
		// Configure label styles
		let labels = [
			idLabel, nameLabel, usernameLabel, emailLabel,
			addressLabel, phoneLabel, websiteLabel, companyLabel
		]
		
		labels.forEach {
			$0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
			$0.textColor = .label
			$0.numberOfLines = 0
		}
		
		// StackView for vertical layout
		let stack = UIStackView(arrangedSubviews: labels)
		stack.axis = .vertical
		stack.spacing = 6
		stack.translatesAutoresizingMaskIntoConstraints = false
		
		contentView.addSubview(stack)
		
		NSLayoutConstraint.activate([
			stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
			stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
			stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
			stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
		])
	}
}
