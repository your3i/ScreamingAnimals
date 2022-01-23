//
//  AppView.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/06.
//

import SwiftUI

struct AppView: View {

	@EnvironmentObject var animalsData: AnimalsData

	@State var favoritesOnly = false

	private var colWidth: CGFloat {
		let colCount: Int = {
			if UIDevice.current.userInterfaceIdiom == .phone {
				return 3
			} else {
				return 4
			}
		}()

		let screenWidth: CGFloat = {
			if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
				return max(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
			} else {
				return min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
			}
		}()

		return floor(Double(screenWidth - 32) / Double(colCount))
	}

    var body: some View {
		NavigationView {
			ScrollView {
				if animalsData.animals.isEmpty {
					ProgressView()
						.padding(.top, 20)
				}
				let width = colWidth
				LazyVGrid(columns: [GridItem(.adaptive(minimum: width, maximum: width), spacing: nil)]) {
					ForEach(animalsData.animals) {
						AnimalView(animal: $0, cellWidth: width)
					}
				}
			}
			.padding(.horizontal, 8.0)
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
