//
//  AppView.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/06.
//

import SwiftUI

fileprivate var cellWidth: CGFloat = {
	if UIDevice.current.userInterfaceIdiom == .phone {
		return 92
	}
	return 160
}()

struct AppView: View {

	@EnvironmentObject var animalsData: AnimalsData

	@State var favoritesOnly = false

	private var columns = [
		GridItem(.adaptive(minimum: cellWidth, maximum: cellWidth))
	]

    var body: some View {
        NavigationView {
			ScrollView {
				LazyVGrid(columns: columns) {
					ForEach(animalsData.animals) {
						AnimalView(animal: $0, cellWidth: cellWidth)
					}
				}
				.padding(.horizontal, 4)
			}
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
		.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
		AppView().environmentObject(AnimalsData())
    }
}
