//
//  Post.swift
//  UIKitTutorial
//
//  Created by Priyatam on 06/12/25.
//

import Foundation
import GRDB

struct Post: Codable, FetchableRecord, PersistableRecord, Identifiable {
	let userId: Int
	let id: Int
	let title: String
	let body: String
}
