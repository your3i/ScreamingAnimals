//
//  DefaultFavoritesRepository.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/13.
//

import Foundation
import Combine

final class DefaultFavoritesRepository: FavoritesRepository {

	private let favoritesStorage: FavoritesStorage

	init(favoritesStorage: FavoritesStorage) {
		self.favoritesStorage = favoritesStorage
	}

	func getFavorites() -> [String] {
		return favoritesStorage.getFavorites()
	}

	func addFavorite(animalID: String) -> AnyPublisher<[String], Never> {
		return favoritesStorage.addFavorite(animalID: animalID)
	}

	func removeFavorite(animalID: String) -> AnyPublisher<[String], Never> {
		return favoritesStorage.removeFavorite(animalID: animalID)
	}
}
