//
//  ShowDetailsVC.swift
//  UIKitTutorial
//
//  Created by Priyatam on 06/12/25.
//

import UIKit

class ShowDetailsVC: UIViewController {
	// MARK: - UI elements
	private let textLabel = UILabel()
	var selectedText: String?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "More details"
		view.backgroundColor = .systemBackground
		
		setupUI()
	}
	
	// MARK: - Setup UI
	private func setupUI() {
		textLabel.text = "\(selectedText ?? "Boss Baby - 1") in Suit"
		textLabel.textColor = .label
		textLabel.backgroundColor = .secondarySystemBackground
		textLabel.textAlignment = .center
		textLabel.layer.cornerRadius = 12
		textLabel.font = .systemFont(ofSize: 32, weight: .medium)
		textLabel.adjustsFontSizeToFitWidth = true
		textLabel.numberOfLines = 1
		textLabel.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(textLabel)
		
		NSLayoutConstraint.activate([
			textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			textLabel.widthAnchor.constraint(equalToConstant: 256),
			textLabel.heightAnchor.constraint(equalToConstant: 64)
		])
	}
}
