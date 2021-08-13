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

	struct AnimalNameDTO: Decodable {
		var en: String
		var ja: String
		var zh: String
	}

	var id: String
	var name: AnimalNameDTO
	var images: [AnimalPhotoDTO]
	var sounds: [URL]
}

extension AnimalDTO {

	func toEntity() -> Animal {
		let image = images.randomElement()
		var localizedName = name.en
		if let preferredLanguage = Bundle.main.preferredLocalizations.first {
			switch preferredLanguage {
			case "zh-Hans", "zh-Hant":
				localizedName = name.zh
			case "ja":
				localizedName = name.ja
			default:
				break
			}
		}
		return Animal(id: id, name: localizedName, image: image?.url, imageCredit: image?.credit, sounds: sounds)
	}
}
