//
//  AboutThisAppView.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/10.
//

import SwiftUI
import StoreKit

struct AboutThisAppView: View {
    var body: some View {
		List {
			Section {
				HStack {
					Text("AboutThisApp.Menu.Version")
					Spacer()
					Text(getVersionNumber())
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

			Section {
				Button {
					if let window = UIApplication.shared.windows.first?.windowScene {
						SKStoreReviewController.requestReview(in: window)
					}
				} label: {
					Text("AboutThisApp.Menu.SubmitAReview")
						.foregroundColor(Color("Text"))
				}
				Button {
					if let url = URL(string: "itms-apps://itunes.apple.com/app/1580740019?action=write-review") {
						UIApplication.shared.open(url, options: [:], completionHandler: nil)
					}
				} label: {
					Text("AboutThisApp.Menu.SendFeedbacks")
						.foregroundColor(Color("Text"))
				}
			}
		}
		.navigationTitle(Text("AboutThisApp.Title"))
    }

	private func getVersionNumber() -> String {
		return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
	}
}

struct AboutThisAppView_Previews: PreviewProvider {
    static var previews: some View {
		AboutThisAppView()
    }
}
