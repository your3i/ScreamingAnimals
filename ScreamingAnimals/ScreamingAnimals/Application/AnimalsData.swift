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
		let url = URL(string: "https://raw.githubusercontent.com/your3i/ScreamingAnimals/main/docs/animals.json")!
		URLSession.shared.dataTaskPublisher(for: url)
			.tryMap { $0.data }
			.decode(type: [Animal].self, decoder: JSONDecoder())
			.receive(on: DispatchQueue.main)
			.sink(
				receiveCompletion: { print("Received completion: \($0).") },
				receiveValue: { [weak self] animals in
					self?.animals = animals
				})
			.store(in: &cancellables)
	}

}
