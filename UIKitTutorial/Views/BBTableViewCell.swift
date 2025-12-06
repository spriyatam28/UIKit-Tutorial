//
//  BirdTableViewCell.swift
//  UIKitTutorial
//
//  Created by Priyatam on 05/12/25.
//

import UIKit

class BBTableViewCell: UITableViewCell {
	// MARK: - Properties (views)
	
	private let bbImage = UIImageView()
	private let bbLabel = UILabel()
	
	static let reuse = "BossBabyTableViewCellReuse"
	
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
	
	func configure(with bossBaby: BossBaby) {
		bbImage.image = UIImage(named: bossBaby.image)
		bbLabel.text = bossBaby.name
	}
	
	// MARK: - Setup UI
	
	private func setupUI() {
		// MARK: - Setup birdImage
		bbImage.contentMode = .scaleAspectFill
		bbImage.layer.cornerRadius = 12
		bbImage.clipsToBounds = true
		bbImage.translatesAutoresizingMaskIntoConstraints = false
		
		contentView.addSubview(bbImage)
		
		// MARK: - Setup birdLabel
		bbLabel.textColor = .label
		bbLabel.adjustsFontSizeToFitWidth = true
		bbLabel.textAlignment = .center
		bbLabel.font = .systemFont(ofSize: 20, weight: .medium)
		bbLabel.translatesAutoresizingMaskIntoConstraints = false
		
		contentView.addSubview(bbLabel)
		let bbImageBottom = bbImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
		bbImageBottom.priority = UILayoutPriority(999)
		
		NSLayoutConstraint.activate([
			bbImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
			bbImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
			bbImageBottom,
			bbImage.widthAnchor.constraint(equalToConstant: 120),
			
			bbLabel.leadingAnchor.constraint(equalTo: bbImage.trailingAnchor, constant: 6),
			bbLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
			bbLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
		])
	}
}
