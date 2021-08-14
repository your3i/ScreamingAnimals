//
//  ScreamingAnimalsApp.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/11.
//

import SwiftUI

@main
struct ScreamingAnimalsApp: App {

	@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

	@StateObject private var animalsData = AnimalsData()

    var body: some Scene {
		WindowGroup {
			AppView()
				.environmentObject(animalsData)
		}
	}
}
