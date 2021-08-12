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

	init() {
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
					self?.animals = result.shuffled()
				}
			)
			.store(in: &cancellables)
	}

}
