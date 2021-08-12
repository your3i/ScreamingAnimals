//
//  LicensesView.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/11.
//

import SwiftUI

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
				destination: WebView(url: URL(string: "https://raw.githubusercontent.com/onevcat/Kingfisher/master/LICENSE")!),
				label: {
					Text("Kingfisher")
				})
			NavigationLink(
				destination: WebView(url: URL(string: "https://raw.githubusercontent.com/quantopian/qgrid/master/LICENSE")!),
				label: {
					Text("QGrid")
				})
		}
		.navigationTitle(Text("Licenses.Title"))
    }
}

struct LicensesView_Previews: PreviewProvider {
    static var previews: some View {
        LicensesView()
    }
}
