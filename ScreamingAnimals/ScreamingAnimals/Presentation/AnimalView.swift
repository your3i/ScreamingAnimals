//
//  AnimalView.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/09.
//

import AVFoundation
import Kingfisher
import SwiftUI

struct AnimalView: View {

	@EnvironmentObject var animalsData: AnimalsData

	@ObservedObject private var viewModel: AnimalViewModel

	@State private var isTapped = false

	let animal: Animal

	let cellWidth: CGFloat

	init(animal: Animal, cellWidth: CGFloat) {
		self.animal = animal
		self.cellWidth = cellWidth
		self.viewModel = AnimalViewModel(animal: animal)
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
					viewModel.playRandomSound()
				}
				return UIMenu(title: "", children: [favoriteAction, playAction])
			}
			.scaleEffect(isTapped ? 1.3 : 1.0)
			.animation(.spring(response: 0.2, dampingFraction: 0.6), value: isTapped)
			.onTapGesture {
				viewModel.playRandomSound()
				isTapped.toggle()
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
					isTapped.toggle()
				}
			}
			HStack {
				Text(animal.name)
					.foregroundColor(Color("Text"))
					.lineLimit(1)
				if viewModel.isPlaying {
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
