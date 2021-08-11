//
//  AnimalView.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/09.
//

import AVFoundation
import Kingfisher
import SwiftUI

private var player: AVPlayer?

private func playShouting(url: URL) {
	player?.cancelPendingPrerolls()
	player = nil
	let playerItem = AVPlayerItem(url: url)
	player = AVPlayer(playerItem: playerItem)
	player?.volume = 1.0
	player?.play()
}

struct AnimalView: View {

	let animal: Animal

	@State private var isTapped = false

	private func playAnimalShouting() {
		if let url = animal.shoutings.randomElement() {
			playShouting(url: url)
		}
	}

    var body: some View {
		VStack() {
			KFImage(animal.image)
				.resizing(referenceSize: CGSize(width: 100, height: 100), mode: .aspectFill)
				.clipShape(Circle())
				.shadow(color: .black, radius: 2)
				.scaleEffect(isTapped ? 1.3 : 1.0)
				.animation(.spring(response: 0.4, dampingFraction: 0.6))
				.onTapGesture {
					playAnimalShouting()
					isTapped.toggle()
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
						isTapped.toggle()
					}
				}
				.frame(width: 120, height: 120)
			Text(animal.name)
				.font(.caption)
				.padding(.bottom, 8)
		}
    }
}

struct AnimalView_Previews: PreviewProvider {
    static var previews: some View {
		let animalImage = URL(string: "https://raw.githubusercontent.com/your3i/ScreamingAnimals/main/docs/resources/lion_1.jpg")
		let animal = Animal(id: "123", name: "animal name", image: animalImage, imageCredit: "credit text", shoutings: [])
		AnimalView(animal: animal)
    }
}
