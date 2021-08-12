//
//  CustomPreviewContextMenu.swift
//  ScreamingAnimals
//
//  Created by nono on 2021/08/12.
//

import SwiftUI

struct CustomPreviewContextMenu<Content: View, Preview: View>: View {

	var content: Content

	var preview: Preview

	var menu: UIMenu

	init(@ViewBuilder content: @escaping () -> Content, @ViewBuilder preview: @escaping () -> Preview, actions: @escaping () -> UIMenu) {
		self.content = content()
		self.preview = preview()
		self.menu = actions()
	}

    var body: some View {
		ZStack {
			content
				.hidden()
				.overlay(
					CustomPreviewContextMenuHelper(content: content, preview: preview, actions: menu)
				)
		}
    }
}

struct CustomPreviewContextMenu_Previews: PreviewProvider {
	static var previews: some View {
		let animalImage = URL(string: "https://raw.githubusercontent.com/your3i/ScreamingAnimals/main/docs/resources/lion_1.jpg")
		let animal = Animal(id: "123", name: "animal name", image: animalImage, imageCredit: "credit text", shoutings: [])
		AnimalView(animal: animal)
	}
}

struct CustomPreviewContextMenuHelper<Content: View, Preview: View>: UIViewRepresentable {

	typealias UIViewType = UIView

	var content: Content

	var preview: Preview

	var actions: UIMenu

	init(content: Content, preview: Preview, actions: UIMenu) {
		self.content = content
		self.preview = preview
		self.actions = actions
	}

	func makeUIView(context: Context) -> UIView {
		let view = UIView()
		view.backgroundColor = .clear

		let hostView = UIHostingController(rootView: content)
		hostView.view.translatesAutoresizingMaskIntoConstraints = false
		let constraints = [
			hostView.view.topAnchor.constraint(equalTo: view.topAnchor),
			hostView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			hostView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			hostView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			hostView.view.widthAnchor.constraint(equalTo: view.widthAnchor),
			hostView.view.heightAnchor.constraint(equalTo: view.heightAnchor)
		]
		view.addSubview(hostView.view)
		view.addConstraints(constraints)

		let interaction = UIContextMenuInteraction(delegate: context.coordinator)
		view.addInteraction(interaction)
		return view
	}

	func updateUIView(_ uiView: UIView, context: Context) {
	}

	func makeCoordinator() -> Coordinator {
		return Coordinator(parent: self)
	}

	class Coordinator: NSObject, UIContextMenuInteractionDelegate {

		var parent: CustomPreviewContextMenuHelper

		init(parent: CustomPreviewContextMenuHelper) {
			self.parent = parent
		}

		func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
			return UIContextMenuConfiguration(identifier: nil) {
				let previewController = UIHostingController(rootView: self.parent.preview)
				previewController.view.backgroundColor = .clear
				return previewController
			} actionProvider: { [weak self] items in
				return self?.parent.actions
			}
		}
	}
}
