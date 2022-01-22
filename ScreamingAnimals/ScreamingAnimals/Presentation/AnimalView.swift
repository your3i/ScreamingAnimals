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

private var playerObserver1: NSObjectProtocol?

private var playerObserver2: NSObjectProtocol?


struct AnimalView: View {

	@EnvironmentObject var animalsData: AnimalsData

	@State private var isTapped = false

	@State private var isPlaying = false

	let animal: Animal

	let cellWidth: CGFloat

	private func playAnimalSoundIfNeeded() {
		guard !isPlaying else {
			stopPlaying()
			isPlaying = false
			return
		}
		if let url = animal.sounds.randomElement() {
			playSound(url: url)
			isPlaying = true
		}
	}

	private func stopPlaying() {
		player?.pause()
		player?.cancelPendingPrerolls()
		player = nil
		if let observer = playerObserver1{
			NotificationCenter.default.removeObserver(observer)
		}
		if let observer = playerObserver2{
			NotificationCenter.default.removeObserver(observer)
		}
	}

	private func playSound(url: URL) {
		player?.cancelPendingPrerolls()
		player = nil
		let playerItem = AVPlayerItem(url: url)
		player = AVPlayer(playerItem: playerItem)
		player?.volume = 1.0
		player?.play()
		playerObserver1 = NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem, queue: .main) { _ in
			isPlaying = false
		}
		playerObserver2 = NotificationCenter.default.addObserver(forName: .AVPlayerItemFailedToPlayToEndTime, object: player?.currentItem, queue: .main) { _ in
			isPlaying = false
		}
	}

    var body: some View {
		VStack {
			CustomPreviewContextMenu {
				KFImage(animal.image)
					.resizing(referenceSize: CGSize(width: cellWidth - 6, height: cellWidth - 6))
					.clipShape(Circle())
					.shadow(color: .black, radius: 2)
			} preview: {
				AnimalPhotoView(animal: animal)
			} actions: {
				let favoriteAction = UIAction(title: NSLocalizedString("Animal.ContextMenu.Action.Favorite", comment: "")) { _ in
					animalsData.toggleFavorite(animalID: animal.id)
				}
				let playAction = UIAction(title: NSLocalizedString("Animal.ContextMenu.Action.Play", comment: "")) { _ in
					playAnimalSoundIfNeeded()
				}
				return UIMenu(title: "", children: [favoriteAction, playAction])
			}
			.scaleEffect(isTapped ? 1.3 : 1.0)
			.animation(isTapped ? .spring(response: 0.2, dampingFraction: 0.6) : .none)
			.onTapGesture {
				playAnimalSoundIfNeeded()
				isTapped.toggle()
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
					isTapped.toggle()
				}
			}
			HStack {
				Text(animal.name)
					.foregroundColor(Color("Text"))
					.lineLimit(1)
				if isPlaying {
					Image(systemName: "play.circle.fill")
						.imageScale(.small)
						.foregroundColor(Color("Brand"))
				} else if animal.isFavorite {
					Image(systemName: "star.fill")
						.imageScale(.small)
						.foregroundColor(Color("Brand"))
				}
			}
			.padding(.bottom, 8)
		}
	}
}

struct AnimalView_Previews: PreviewProvider {
    static var previews: some View {
		let animalImage = URL(string: "https://raw.githubusercontent.com/your3i/ScreamingAnimals/main/docs/resources/lion_1.jpg")
		let animal = Animal(id: "123", name: "animal name", image: animalImage, imageCredit: "credit text", sounds: [])
		AnimalView(animal: animal, cellWidth: 92)
    }
}
