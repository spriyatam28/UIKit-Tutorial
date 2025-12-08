//
//  PostRepository.swift
//  UIKitTutorial
//
//  Created by Priyatam on 08/12/25.
//

import Foundation
import GRDB

final class PostRepository {
	static let shared = PostRepository()
	private let db = Storage.shared.dbQueue
	
	private init() {}
	
	// MARK: - CREATE
	func insert(_ post: Post) throws {
		try db.write { db in
			try post.save(db)
		}
	}
	
	func insertAll(_ posts: [Post]) throws {
		try db.write { db in
			try posts.forEach { post in
				try post.save(db)
			}
		}
	}
	
	// MARK: - READ
	func fetchById(id: Int) throws -> Post? {
		try db.read { db in
			try Post.fetchOne(db, key: id)
		}
	}
	
	func fetchAll() throws -> [Post]? {
		try db.read { db in
			try Post.fetchAll(db)
		}
	}
	
	// MARK: - UPDATE
	func update(_ post: Post) throws {
		try db.write { db in
			try post.update(db)
		}
	}
	
	// MARk: - DELETE
	func deleteAll() throws {
		try db.write { db in
			_ = try Post.deleteAll(db)
		}
	}
	
	func deleteById(id: Int) throws {
		try db.write { db in
			_ = try Post.deleteOne(db, key: id)
		}
	}
}
