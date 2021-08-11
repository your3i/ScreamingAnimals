//
//  AnimalsRepository.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/11.
//

import Foundation
import Combine

protocol AnimalsRepository {

	func getAnimals() -> AnyPublisher<[Animal], Error>
}
