//
//  AddFavoriteUseCase.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/13.
//

import Foundation
import Combine

protocol AddFavoriteUseCase {

	func execute(animalID: String) -> AnyPublisher<[String], Never>
}

final class DefaultAddFavoriteUseCase: AddFavoriteUseCase {

	private let favoritesRepository: FavoritesRepository

	init(favoritesRepository: FavoritesRepository) {
		self.favoritesRepository = favoritesRepository
	}

	func execute(animalID: String) -> AnyPublisher<[String], Never> {
		return favoritesRepository.addFavorite(animalID: animalID)
	}
}
