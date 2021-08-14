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
	var image: URL?
	var imageCredit: String?
	var sounds: [URL]
	var isFavorite: Bool = false
}
