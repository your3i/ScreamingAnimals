//
//  AnimalDTO.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/11.
//

import Foundation

struct AnimalDTO: Decodable {

	struct AnimalPhotoDTO: Decodable {
		var url: URL
		var credit: String
	}

	var id: String
	var name: String
	var images: [AnimalPhotoDTO]
	var shoutings: [URL]
}

extension AnimalDTO {

	func toEntity() -> Animal {
		let image = images.randomElement()
		return Animal(id: id, name: name, image: image?.url, imageCredit: image?.credit, shoutings: shoutings)
	}
}
