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
				.navigationTitle("Home.Title")
				.navigationBarItems(
					leading:
						NavigationLink(
							destination: AboutThisAppView(),
							label: { Image(systemName: "info.circle.fill") }
						),
					trailing:
						HStack {
							Menu {
								Button(action: { animalsData.sortInAscendingOrder() }, label: {
									Text("Home.Menu.InAscendingOrder")
								})
								Button(action: { animalsData.sortInDescendingOrder() }, label: {
									Text("Home.Menu.InDescendingOrder")
								})
								Button(action: { animalsData.shuffle() }, label: {
									Text("Home.Menu.Shuffle")
								})
							} label: {
								Image(systemName: "arrow.up.arrow.down.circle")
							}
							Button(
								action: { print("tapped") },
								label: {
									Image(systemName: "line.horizontal.3.decrease.circle")
								}
							)
							.padding(.leading, 16)
						}
				)
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
		AppView().environmentObject(AnimalsData())
    }
}
