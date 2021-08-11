//
//  DefaultAnimalsRepository.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/11.
//

import Foundation
import Combine

final class DefaultAnimalsRepository: AnimalsRepository {

	private let jsonURL: String

	init(_ jsonURL: String) {
		self.jsonURL = jsonURL
	}

	func getAnimals() -> AnyPublisher<[Animal], Error> {
		return APIEndpoints.getAnimals(jsonURL)
			.map { $0.map { $0.toEntity() } }
			.eraseToAnyPublisher()
	}
}
