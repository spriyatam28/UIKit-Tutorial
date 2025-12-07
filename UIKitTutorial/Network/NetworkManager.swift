//
//  Networking.swift
//  UIKitTutorial
//
//  Created by Priyatam on 06/12/25.
//

import Foundation
import Alamofire

class NetworkManager {
	static let shared = NetworkManager()
	
	//MARK: - API Endpoint
	private let URLEndPoint = "https://jsonplaceholder.typicode.com"
	
	private init() {}
	
	func fetchPosts(completion: @escaping([Post]) -> Void) {
		let endpoint = URLEndPoint + "/posts"
		let decoder = JSONDecoder()
		// Only use if you need to decode date strings
		decoder.dateDecodingStrategy = .iso8601
		// Convert snake case to camel case
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		
		AF.request(endpoint, method: .get)
			.validate()
			.responseDecodable(of: [Post].self, decoder: decoder) { response in
				switch response.result {
					case .success(let posts):
						print("Successfully got posts!!! Total: \(posts.count)")
						completion(posts)
					case .failure(let error):
						print("error: \(error.localizedDescription)")
				}
			}
	}
	
	func fetchUsers(completion: @escaping([User]) -> Void) {
		let endpoint = URLEndPoint + "/users"
		let decoder = JSONDecoder()
		
		decoder.dateDecodingStrategy = .iso8601
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		
		AF.request(endpoint, method: .get)
			.validate()
			.responseDecodable(of: [User].self, decoder: decoder) { response in
				switch response.result {
					case .success(let users):
						print("Successfully got users!!! Total: \(users.count)")
						completion(users)
					case .failure(let error):
						print("error: \(error.localizedDescription)")
				}
			}
	}
}
