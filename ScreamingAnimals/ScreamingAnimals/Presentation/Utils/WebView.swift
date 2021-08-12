//
//  WebView.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/11.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

	typealias UIViewType = WKWebView

	private let request: URLRequest

	init(url: URL) {
		self.request = URLRequest(url: url)
	}

	func makeUIView(context: Context) -> WKWebView {
		return WKWebView()
	}

	func updateUIView(_ uiView: WKWebView, context: Context) {
		uiView.load(request)
	}
}
