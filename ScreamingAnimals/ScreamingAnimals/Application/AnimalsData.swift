//
//  AnimalsData.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/09.
//

import Foundation
import Combine

final class AnimalsData: ObservableObject {

	@Published var animals: [Animal] = []

	private var cancellables = Set<AnyCancellable>()

	private let favoritesStorage: FavoritesStorage

	private let favoritesRepository: FavoritesRepository

	init() {
		self.favoritesStorage = UserDefaultsFavoritesStorage(userDefaults: UserDefaults.standard)
		self.favoritesRepository = DefaultFavoritesRepository(favoritesStorage: self.favoritesStorage)
		fetch()
	}

	private func fetch() {
		let jsonURL = "https://raw.githubusercontent.com/your3i/ScreamingAnimals/main/docs/animals.json"
		DefaultAnimalsRepository(jsonURL)
			.getAnimals()
			.receive(on: DispatchQueue.main)
			.sink(
				receiveCompletion: {
					print("Received completion: \($0).")
				},
				receiveValue: { [weak self] result in
					guard let strongSelf = self else {
						return
					}
					strongSelf.animals = result.shuffled()
					strongSelf.updateAnimalFavorites(favoriteIDs: strongSelf.favoritesRepository.getFavorites())
				}
			)
			.store(in: &cancellables)
	}

	func sortInAscendingOrder() {
		animals = animals.sorted { $0.name <= $1.name }
	}

	func sortInDescendingOrder() {
		animals = animals.sorted { $0.name >= $1.name }
	}

	func shuffle() {
		animals = animals.shuffled()
	}

	func addFavorite(animalID: String) {
		let useCase = DefaultAddFavoriteUseCase(favoritesRepository: favoritesRepository)
		useCase.execute(animalID: animalID)
			.receive(on: DispatchQueue.main)
			.sink { [weak self] favoriteIDs in
				self?.updateAnimalFavorites(favoriteIDs: favoriteIDs)
			}
			.store(in: &cancellables)
	}

	func removeFavorite(animalID: String) {
		let useCase = DefaultRemoveFavoriteUseCase(favoritesRepository: favoritesRepository)
		useCase.execute(animalID: animalID)
			.receive(on: DispatchQueue.main)
			.sink { [weak self] favoriteIDs in
				self?.updateAnimalFavorites(favoriteIDs: favoriteIDs)
			}
			.store(in: &cancellables)
	}

	private func updateAnimalFavorites(favoriteIDs: [String]) {
		var newAnimalsArray: [Animal] = []
		for var animal in animals {
			animal.isFavorite = favoriteIDs.contains(animal.id)
			newAnimalsArray.append(animal)
		}
		objectWillChange.send()
		animals = newAnimalsArray
	}
}
