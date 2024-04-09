//
//  SoundPlayerService.swift
//  ScreamingAnimals
//
//  Created by your3i on 2022/01/30.
//

import Foundation
import Combine
import AVFoundation

final class SoundPlayerService {

	private let player = AVPlayer()

	private var itemDidPlayToEndTimeObserver: NSObjectProtocol?

	private var itemFailedToPlayToEndTimeObserver: NSObjectProtocol?

	static let shared = SoundPlayerService()

	let currentPlayingItem: PassthroughSubject<URL?, Never> = PassthroughSubject()

	private init() {
		try? AVAudioSession.sharedInstance().setCategory(.playback)
	}

	func play(_ url: URL) {
		let item = AVPlayerItem(url: url)
		player.replaceCurrentItem(with: item)
		player.volume = 1.0
		player.play()
		currentPlayingItem.send(url)

		itemDidPlayToEndTimeObserver = NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { [weak self] _ in
			self?.currentPlayingItem.send(nil)
		}

		itemFailedToPlayToEndTimeObserver = NotificationCenter.default.addObserver(forName: .AVPlayerItemFailedToPlayToEndTime, object: player.currentItem, queue: .main) { [weak self] _ in
			self?.currentPlayingItem.send(nil)
		}
	}

	func stopPlaying(_ url: URL) {
		guard let currentItem = player.currentItem else {
			return
		}
		guard let currentURL = ((currentItem.asset) as? AVURLAsset)?.url else {
			return
		}
		guard url == currentURL else {
			return
		}
		player.pause()
		player.replaceCurrentItem(with: nil)
		currentPlayingItem.send(nil)
	}
}
