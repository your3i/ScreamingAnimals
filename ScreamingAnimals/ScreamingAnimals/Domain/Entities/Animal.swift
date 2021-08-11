//
//  Animal.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/06.
//

import Foundation
import Combine

struct Animal: Equatable, Identifiable {
	var id: String
    var name: String
	var images: [AnimalPhoto]
	var shoutings: [URL]
	var firstImage: URL?

	struct AnimalPhoto: Equatable, Decodable {
		var url: URL
		var credit: String
	}
}

extension Animal: Decodable {

	enum CodingKeys: String, CodingKey {
		case id
		case name
		case images
		case shoutings
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decode(String.self, forKey: .id)
		name = try values.decode(String.self, forKey: .name)
		images = try values.decode([AnimalPhoto].self, forKey: .images)
		shoutings = try values.decode([URL].self, forKey: .shoutings)
		firstImage = images.randomElement()?.url
	}
}
