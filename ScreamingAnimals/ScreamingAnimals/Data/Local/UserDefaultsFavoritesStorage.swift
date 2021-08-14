//
//  UserDefaultsFavoritesStorage.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/13.
//

import Foundation
import Combine

final class UserDefaultsFavoritesStorage: FavoritesStorage {

	let userDefaults: UserDefaults

	private let kFavorites = "kFavorites"

	init(userDefaults: UserDefaults) {
		self.userDefaults = userDefaults
	}

	func getFavorites() -> [String] {
		guard let array = userDefaults.array(forKey: kFavorites) else {
			return []
		}
		return array.map { ($0 as? String) ?? "" }
	}

	func addFavorite(animalID: String) -> AnyPublisher<[String], Never> {
		var current = getFavorites()
		guard !current.contains(animalID) else {
			return Just(current).eraseToAnyPublisher()
		}
		current.append(animalID)
		saveFavorites(animalIDs: current)
		return Just(current).eraseToAnyPublisher()
	}

	func removeFavorite(animalID: String) -> AnyPublisher<[String], Never> {
		var current = getFavorites()
		guard let index = current.firstIndex(of: animalID) else {
			return Just(current).eraseToAnyPublisher()
		}
		current.remove(at: index)
		saveFavorites(animalIDs: current)
		return Just(current).eraseToAnyPublisher()
	}

	private func saveFavorites(animalIDs: [String]) {
		userDefaults.setValue(animalIDs, forKey: kFavorites)
	}
}
