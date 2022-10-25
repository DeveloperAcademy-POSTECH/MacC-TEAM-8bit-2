//
//  VideoPlayView.swift
//  OrrRock
//
//  Created by kimhyeongmin on 2022/10/23.
//

import AVFoundation
import UIKit

final class VideoPlayView: UIView {
	
	private lazy var videoBackgroundView: UIView = {
		let view = UIView()
		return view
	}()
	
	var player = AVPlayer()
	private var playerLayer: AVPlayerLayer?
	private let asset: AVAsset
	
	init(asset: AVAsset) {
		self.asset = asset
		super.init(frame: .zero)
		
		setUpLayout()
		embedVideo()
	}
	
	required init?(coder: NSCoder) {
		fatalError()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		self.playerLayer?.frame = self.videoBackgroundView.bounds
	}
}

// AVPlayerLayer에 AVAsset파일을 받아와서 띄워주는 코드
private extension VideoPlayView {
	
	func embedVideo() {
		let item = AVPlayerItem(asset: asset)
		self.player.replaceCurrentItem(with: item)
		let playerLayer = AVPlayerLayer(player: self.player)
		playerLayer.frame = self.videoBackgroundView.bounds
		playerLayer.videoGravity = .resizeAspectFill
		self.playerLayer = playerLayer
		self.videoBackgroundView.layer.addSublayer(playerLayer)
		self.player.isMuted = true
		self.player.play()
	}
}

private extension VideoPlayView {
	
	func setUpLayout() {
		// AVPlayerLayer의 뒤에 위치할 뷰
		self.addSubview(videoBackgroundView)
		videoBackgroundView.snp.makeConstraints {
			$0.top.leading.trailing.equalToSuperview()
			$0.bottom.equalToSuperview().inset(50)
		}
	}
}
