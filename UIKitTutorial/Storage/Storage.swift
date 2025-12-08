//
//  Storage.swift
//  UIKitTutorial
//
//  Created by Priyatam on 08/12/25.
//

import GRDB
import Foundation

final class Storage {
	static let shared = try! Storage()
	let dbQueue: DatabaseQueue
	
	init() throws {
		let fileURL = try FileManager.default
			.url(
				for: .documentDirectory,
				in: .userDomainMask,
				appropriateFor: nil,
				create: true
			)
			.appendingPathComponent("database.sqlit")
		
		dbQueue = try DatabaseQueue(path: fileURL.path())
		
		try migrator.migrate(dbQueue)
	}
}

extension Storage {
	/// DB migrations creates table
	
	var migrator: DatabaseMigrator {
		var migrator = DatabaseMigrator()
		
		migrator.registerMigration("createPost") { db in
			try db.create(table: "post") { t in
				t.column("id", .integer).primaryKey()
				t.column("userId", .integer).notNull()
				t.column("title", .text).notNull()
				t.column("body", .text).notNull()
			}
		}
		
		return migrator
	}
}
