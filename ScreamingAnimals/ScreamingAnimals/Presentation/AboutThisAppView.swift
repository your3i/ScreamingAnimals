//
//  AboutThisAppView.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/10.
//

import SwiftUI

struct AboutThisAppView: View {
    var body: some View {
		List {
			HStack {
				Text("AboutThisApp.Menu.Version")
				Spacer()
				Text("1.0")
			}
			NavigationLink(
				destination: LicensesView(),
				label: {
					Text("AboutThisApp.Menu.Licenses")
				})
		}
		.navigationTitle(Text("AboutThisApp.Title"))
    }
}

struct AboutThisAppView_Previews: PreviewProvider {
    static var previews: some View {
		AboutThisAppView()
    }
}
