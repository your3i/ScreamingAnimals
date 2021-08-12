//
//  AppDelegate.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/06.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(named: "Text")!]
		UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: "Text")!]
		return true
	}
}
