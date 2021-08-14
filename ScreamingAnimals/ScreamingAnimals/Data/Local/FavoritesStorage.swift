//
//  FavoritesStorage.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/13.
//

import Foundation
import Combine

protocol FavoritesStorage {

	func getFavorites() -> [String]

	func addFavorite(animalID: String) -> AnyPublisher<[String], Never>

	func removeFavorite(animalID: String) -> AnyPublisher<[String], Never>
}
