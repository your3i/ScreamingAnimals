//
//  RemoveFavoriteUseCase.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/13.
//

import Foundation
import Combine

protocol RemoveFavoriteUseCase {

	func execute(animalID: String) -> AnyPublisher<[String], Never>
}

final class DefaultRemoveFavoriteUseCase: RemoveFavoriteUseCase {

	private let favoritesRepository: FavoritesRepository

	init(favoritesRepository: FavoritesRepository) {
		self.favoritesRepository = favoritesRepository
	}

	func execute(animalID: String) -> AnyPublisher<[String], Never> {
		return favoritesRepository.removeFavorite(animalID: animalID)
	}
}
