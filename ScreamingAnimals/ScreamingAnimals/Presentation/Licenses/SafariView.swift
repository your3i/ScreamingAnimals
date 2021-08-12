//
//  SafariView.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/12.
//

import Foundation
import SafariServices
import SwiftUI

struct SafariView: UIViewControllerRepresentable {

	typealias UIViewControllerType = SFSafariViewController

	private let url: URL

	init(url: URL) {
		self.url = url
	}

	func makeUIViewController(context: Context) -> SFSafariViewController {
		return SFSafariViewController(url: url)
	}

	func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
	}
}
