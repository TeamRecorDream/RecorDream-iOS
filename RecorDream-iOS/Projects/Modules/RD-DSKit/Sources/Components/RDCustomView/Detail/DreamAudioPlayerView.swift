//
//  DreamAudioView.swift
//  RD-DSKit
//
//  Created by 김수연 on 2022/12/19.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import AVFoundation
import UIKit

import SnapKit
import RxSwift
import RxCocoa

public final class DreamAudioPlayerView: UIView {

    private enum playStatus {
        case notStart
        case playing
        case stop
    }

    private enum Metric {
        static let playButtonTopBottom = 8.f
        static let playButtonLeading = 14.f
        static let playButtonSize = 24.f

        static let playLabelLeading = 6.f
        static let playLabelTop = 11.f

        static let playSliderLeading = 7.f
        static let playSliderTop = 18.f
        static let playSliderTrailing = 15.f
        static let playSliderHeight = 4.f
    }

    private let disposeBag = DisposeBag()

    private var audioPlayer: AVAudioPlayer!
    private var audioTimer: Timer!
    private var audioFile: URL?
    private let timePlayerSelector: Selector = #selector(updatePlayTime)

    private var playStatus = playStatus.notStart

    private lazy var playAndPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(RDDSKitAsset.Images.icnStart.image, for: .normal)
        button.setImage(RDDSKitAsset.Images.icnStop.image, for: .selected)
        return button
    }()

    private var audioPlayTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "03:00"
        label.font = RDDSKitFontFamily.Pretendard.medium.font(size: 12)
        label.textColor = RDDSKitAsset.Colors.white01.color
        return label
    }()

    private lazy var playSlider: UIProgressView = {
        let progress = UIProgressView()
        progress.tintColor = RDDSKitAsset.Colors.white01.color
        progress.trackTintColor = RDDSKitAsset.Colors.dark.color
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()


    // MARK: - View Life Cycle

    public init(voiceUrl: URL?, frame: CGRect) {
        self.audioFile = voiceUrl

        super.init(frame: .zero)

        self.setUI()
        self.setLayout()
        self.bind()
        self.initPlay()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI & Layouts

    private func setUI() {
        self.backgroundColor = RDDSKitAsset.Colors.white05.color
        self.layer.borderWidth = 1
        self.layer.borderColor = RDDSKitAsset.Colors.white05.color.cgColor
        self.makeRounded(radius: 8)
    }

    private func setLayout() {
        self.addSubviews(playAndPauseButton, audioPlayTimeLabel, playSlider)

        playAndPauseButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(Metric.playButtonTopBottom)
            $0.leading.equalToSuperview().inset(Metric.playButtonLeading)
            $0.width.height.equalTo(Metric.playButtonSize)
        }

        audioPlayTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(playAndPauseButton.snp.trailing).offset(Metric.playLabelLeading)
            $0.top.bottom.equalToSuperview().inset(Metric.playLabelTop)
        }

        playSlider.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Metric.playSliderTop)
            $0.leading.equalTo(audioPlayTimeLabel.snp.trailing).offset(Metric.playSliderLeading)
            $0.trailing.equalToSuperview().inset(Metric.playSliderTrailing)
            $0.height.equalTo(Metric.playSliderHeight)
        }
    }
}

extension DreamAudioPlayerView {
    private func initPlay() {
        guard let audioFile = self.audioFile else { return }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)

            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
            audioPlayTimeLabel.text = convertNSTimeInterval2String(audioPlayer.duration)

        } catch let error as NSError {
            print("Error-initPlay : \(error)")
        }

        playSlider.progress = 0

        // 녹음 파일의 총 재생시간
        playAndPauseButton.isSelected = false
    }

    private func convertNSTimeInterval2String(_ time: TimeInterval) -> String {
        let minute = Int(time/60)
        let second = Int(time.truncatingRemainder(dividingBy: 60))
        let strTime = String(format: "%02d:%02d", minute, second)
        return strTime
    }

    private func setPlayStatus(_ play: Bool) {
        playAndPauseButton.isSelected = play
    }

    private func setTimer() {
        audioTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
    }

    @objc private func updatePlayTime() {
        audioPlayTimeLabel.text = convertNSTimeInterval2String(audioPlayer.currentTime)
        playSlider.progress = Float(audioPlayer.currentTime/audioPlayer.duration)
    }

    private func bind() {
        playAndPauseButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self,
                      let player = self.audioPlayer else { return }
                self.setTimer()
                if player.isPlaying {
                    self.setPlayStatus(false)
                    player.pause()
                } else {
                    self.setPlayStatus(true)
                    player.play()
                }
            })
            .disposed(by: self.disposeBag)
    }
}

extension DreamAudioPlayerView: AVAudioPlayerDelegate {
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        audioTimer.invalidate()

        self.playAndPauseButton.isSelected = false
        self.playSlider.progress = 0
        self.audioPlayTimeLabel.text = convertNSTimeInterval2String(audioPlayer.duration)
    }
}
