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

	@State var favoritesOnly = false

    var body: some View {
        NavigationView {
			QGrid(
				animalsData.animals.filter { !favoritesOnly || $0.isFavorite },
				columns: 3,
				columnsInLandscape: 4) { AnimalView(animal: $0) }
				.navigationTitle("Home.Title")
				.navigationBarItems(
					leading:
						NavigationLink(
							destination: AboutThisAppView(),
							label: { Image(systemName: "info.circle") }
						),
					trailing:
						HStack {
							Menu {
								Button(action: { animalsData.sortInAscendingOrder() }, label: {
									Text("Home.ReorderMenu.InAscendingOrder")
								})
								Button(action: { animalsData.sortInDescendingOrder() }, label: {
									Text("Home.ReorderMenu.InDescendingOrder")
								})
								Button(action: { animalsData.shuffle() }, label: {
									Text("Home.ReorderMenu.Shuffle")
								})
							} label: {
								Image(systemName: "arrow.up.arrow.down.circle")
							}
							Menu {
								Button(action: { favoritesOnly = false}, label: {
									Text("Home.FilterMenu.ShowAll")
								})
								Button(action: { favoritesOnly = true }, label: {
									Text("Home.FilterMenu.ShowFavoritesOnly")
								})
							} label: {
								Image(systemName: "line.horizontal.3.decrease.circle")
							}
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
