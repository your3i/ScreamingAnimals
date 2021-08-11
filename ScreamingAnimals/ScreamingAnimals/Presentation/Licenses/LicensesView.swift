//
//  LicensesView.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/11.
//

import SwiftUI

private let kingfisherURL = Bundle.main.url(forResource: "Kingfisher", withExtension: "html")!
private let qGridURL = Bundle.main.url(forResource: "QGrid", withExtension: "html")!

struct LicensesView: View {
    var body: some View {
		List {
			Link(
				destination: URL(string: "https://www.zapsplat.com")!,
				label: {
					VStack(alignment: .leading) {
						Text("ZAPSPLAT")
						Spacer()
						Text("Sound effects obtained from https://www.zapsplat.com")
							.font(.caption2)
							.foregroundColor(.gray)
					}
				})
			Link(
				destination: URL(string: "https://www.pexels.com/")!,
				label: {
					VStack(alignment: .leading) {
						Text("Pexels")
						Spacer()
						Text("Photos obtained from Pexels")
							.font(.caption2)
							.foregroundColor(.gray)
					}
				})
			NavigationLink(
				destination: WebView(url: kingfisherURL),
				label: {
					Text("Kingfisher")
				})
			NavigationLink(
				destination: WebView(url: qGridURL),
				label: {
					Text("QGrid")
				})
		}
		.navigationTitle(Text("Licenses"))
    }
}

struct LicensesView_Previews: PreviewProvider {
    static var previews: some View {
        LicensesView()
    }
}
