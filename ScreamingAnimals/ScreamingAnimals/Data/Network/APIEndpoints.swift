//
//  APIEndpoints.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/11.
//

import Foundation
import Combine

struct APIEndpoints {

	static func getAnimals(_ jsonURL: String) -> AnyPublisher<[AnimalDTO], Error> {
		let url = URL(string: jsonURL)!
		return URLSession.shared.dataTaskPublisher(for: url)
			.tryMap { $0.data }
			.decode(type: [AnimalDTO].self, decoder: JSONDecoder())
			.eraseToAnyPublisher()
	}
}
