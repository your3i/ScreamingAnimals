//
//  AnimalView.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/09.
//

import Kingfisher
import SwiftUI

struct AnimalView: View {

	@EnvironmentObject var animalsData: AnimalsData

	@ObservedObject private var viewModel: AnimalViewModel

	@State private var isTapped = false

	let animal: Animal

	let cellWidth: CGFloat

	init(animal: Animal, cellWidth: CGFloat) {
		self.cellWidth = cellWidth
		self.viewModel = AnimalViewModel(animal: animal)
		self.animal = animal
	}

	var body: some View {
		VStack {
			KFImage(animal.image)
				.resizable()
				.scaledToFill()
				.frame(width: cellWidth - 6, height: cellWidth - 6)
				.clipShape(Circle())
				.contentShape(.contextMenuPreview, Circle())
				.shadow(color: .black, radius: 1)
				.contextMenu {
					Button {
						animalsData.toggleFavorite(animalID: animal.id)
					} label: {
						Label(animal.isFavorite ? NSLocalizedString("Animal.ContextMenu.Action.Favorite.Remove", comment: "") : NSLocalizedString("Animal.ContextMenu.Action.Favorite", comment: ""), systemImage: animal.isFavorite ? "star.fill" : "star")
					}

					Button {
						viewModel.playRandomSound()
					} label: {
						Label(NSLocalizedString("Animal.ContextMenu.Action.Play", comment: ""), systemImage: "play.circle")
					}
				} preview: {
					AnimalPhotoView(animal: animal)
				}
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
