//
//  AppView.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/06.
//

import SwiftUI
import QGrid

struct AppView: View {
	@EnvironmentObject var animalsData: AnimalsData

    var body: some View {
        NavigationView {
			QGrid(
				animalsData.animals,
				columns: 3,
				columnsInLandscape: 4) { AnimalView(animal: $0) }
                .navigationTitle("Screaming Animals")
				.navigationBarItems(
					trailing: NavigationLink(
						destination: AboutThisAppView(),
						label: { Image(systemName: "info.circle.fill") }
					)
				)
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
		AppView().environmentObject(AnimalsData())
    }
}
