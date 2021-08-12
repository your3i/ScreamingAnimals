//
//  AnimalPhotoView.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/12.
//

import Kingfisher
import SwiftUI

struct AnimalPhotoView: View {

	let animal: Animal

    var body: some View {
		ZStack {
			KFImage(animal.image)
				.resizable()
				.scaledToFill()
				.overlay(
					Text(animal.imageCredit ?? "")
						.font(.footnote)
						.foregroundColor(.white)
						.padding(),
					alignment: .bottom
				)
		}
    }
}

struct AnimalPhotoView_Previews: PreviewProvider {
    static var previews: some View {
		let animalImage = URL(string: "https://raw.githubusercontent.com/your3i/ScreamingAnimals/main/docs/resources/lion_1.jpg")
		let animal = Animal(id: "123", name: "animal name", image: animalImage, imageCredit: "credit text", shoutings: [])
        AnimalPhotoView(animal: animal)
    }
}
