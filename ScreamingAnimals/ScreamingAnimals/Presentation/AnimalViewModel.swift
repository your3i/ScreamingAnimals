//
//  AnimalViewModel.swift
//  ScreamingAnimals
//
//  Created by your3i on 2022/01/30.
//

import Foundation
import Combine

final class AnimalViewModel: ObservableObject {

	@Published var isPlaying = false

	private var animal: Animal

	private var cancellables: [AnyCancellable] = []

	init(animal: Animal) {
		self.animal = animal

		SoundPlayerService.shared.currentPlayingItem
			.sink { [weak self] current in
				guard let current = current else {
					self?.isPlaying = false
					return
				}
				self?.isPlaying = self?.animal.sounds.contains(current) ?? false
			}
			.store(in: &cancellables)
	}

	func playRandomSound() {
		guard let url = animal.sounds.randomElement() else {
			return
		}
		SoundPlayerService.shared.play(url)
	}
}
