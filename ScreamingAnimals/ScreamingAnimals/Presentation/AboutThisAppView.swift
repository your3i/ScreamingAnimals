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
			NavigationLink(
				destination: WebView(url: URL(string: "https://screaming-animals.glitch.me/privacy-policy.html")!)
					.navigationTitle("AboutThisApp.Menu.PrivacyPolicy"),
				label: {
					Text("AboutThisApp.Menu.PrivacyPolicy")
				})
			NavigationLink(
				destination: WebView(url: URL(string: "https://screaming-animals.glitch.me/terms_conditions.html")!)
					.navigationTitle("AboutThisApp.Menu.TermsConditions"),
				label: {
					Text("AboutThisApp.Menu.TermsConditions")
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
