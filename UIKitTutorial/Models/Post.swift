//
//  Post.swift
//  UIKitTutorial
//
//  Created by Priyatam on 06/12/25.
//

import Foundation

struct Post: Codable, Sendable {
	let userId: Int
	let id: Int
	let title: String
	let body: String
}
