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

private func playSound(url: URL) {
	player?.cancelPendingPrerolls()
	player = nil
	let playerItem = AVPlayerItem(url: url)
	player = AVPlayer(playerItem: playerItem)
	player?.volume = 1.0
	player?.play()
}

struct AnimalView: View {

	@EnvironmentObject var animalsData: AnimalsData

	@State private var isTapped = false

	let animal: Animal

	private func playAnimalSound() {
		if let url = animal.sounds.randomElement() {
			playSound(url: url)
		}
	}

    var body: some View {
		VStack() {
			CustomPreviewContextMenu {
				KFImage(animal.image)
					.resizing(referenceSize: CGSize(width: 100, height: 100), mode: .aspectFill)
					.clipShape(Circle())
					.shadow(color: .black, radius: 2)
					.frame(width: 120, height: 120)
			} preview: {
				AnimalPhotoView(animal: animal)
			} actions: {
				let iconImage = animal.isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
				let favoriteAction = UIAction(title: NSLocalizedString("Animal.ContextMenu.Action.Favorite", comment: ""), image: iconImage) { _ in
					if animal.isFavorite {
						animalsData.removeFavorite(animalID: animal.id)
					} else {
						animalsData.addFavorite(animalID: animal.id)
					}
				}
				let playAction = UIAction(title: NSLocalizedString("Animal.ContextMenu.Action.Play", comment: ""), image: UIImage(systemName: "play")) { _ in
					playAnimalSound()
				}
				return UIMenu(title: "", children: [favoriteAction, playAction])
			}
			.scaleEffect(isTapped ? 1.3 : 1.0)
			.animation(.spring(response: 0.4, dampingFraction: 0.6))
			.onTapGesture {
				playAnimalSound()
				isTapped.toggle()
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
					isTapped.toggle()
				}
			}
			Text(animal.name)
				.font(.caption)
				.foregroundColor(Color("Text"))
				.padding(.bottom, 8)
		}
    }
}

struct AnimalView_Previews: PreviewProvider {
    static var previews: some View {
		let animalImage = URL(string: "https://raw.githubusercontent.com/your3i/ScreamingAnimals/main/docs/resources/lion_1.jpg")
		let animal = Animal(id: "123", name: "animal name", image: animalImage, imageCredit: "credit text", sounds: [])
		AnimalView(animal: animal)
    }
}
