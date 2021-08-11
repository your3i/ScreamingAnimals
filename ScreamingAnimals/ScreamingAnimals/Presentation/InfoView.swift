//
//  InfoView.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/10.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
		List {
			HStack {
				Text("Version")
				Spacer()
				Text("1.0.0")
			}
			Text("Licenses")
			Text("OS Settings")
		}
		.navigationTitle(Text("Settings"))
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
