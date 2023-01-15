//
//  DreamRecordPage.swift
//  Presentation
//
//  Created by 김수연 on 2022/12/20.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_DSKit

import RxSwift
import SnapKit

public final class DreamRecordViewController: UIViewController {

    // MARK: - Properties

    private enum Metric {
        static let audioViewTop = 12.f
        static let audioViewLeadingTrailing = 6.f
        static let noteLabelTop = 12.f
    }

    private var voiceUrl: URL?
    private var content: String

    // MARK: - UI Components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 14)
        label.textColor = RDDSKitAsset.Colors.white01.color
        label.text = "나의 꿈 기록"
        return label
    }()

    private let placeHolder: UILabel = {
        let label = UILabel()
        label.text = "기록된 내용이 없어요."
        label.font = RDDSKitFontFamily.Pretendard.regular.font(size: 14)
        label.textColor = RDDSKitAsset.Colors.white04.color
        return label
    }()

    private lazy var dreamAudioPlayerView: DreamAudioPlayerView = {
        let recordView = DreamAudioPlayerView(voiceUrl: self.voiceUrl, frame: .zero)
        return recordView
    }()

    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = RDDSKitFontFamily.Pretendard.regular.font(size: 14)
        label.textColor = RDDSKitAsset.Colors.white01.color
        label.numberOfLines = 0
        return label
    }()
    

    // MARK: - View Life Cycle

    init(voiceUrl: URL?, content: String) {
        self.voiceUrl = voiceUrl
        self.content = content

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.setUI()
        self.setLayout()
    }

    // MARK: - UI & Layout
    private func setUI() {
        self.view.backgroundColor = .none
        self.contentLabel.addLabelSpacing(kernValue: -0.14, lineSpacing: 5.6)
    }

    private func setLayout() {
        self.view.addSubviews(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }

        // 1. 녹음 x, 내용 x
        if voiceUrl == nil && content.isEmpty {
            setPlaceHolder(isExistAudio: false)
        } else if voiceUrl == nil && !content.isEmpty {
            // 2. 녹음 x, 내용 o
            setContentLabel(isExistAudio: false)
        } else if voiceUrl != nil && content.isEmpty {
            // 3. 녹음 o, 내용 x
            setAudioPlayer()
            setPlaceHolder(isExistAudio: true)
        } else if voiceUrl != nil && !content.isEmpty {
            // 4. 녹음 o, 내용 o
            setAudioPlayer()
            setContentLabel(isExistAudio: true)
        }
    }

    private func setContentLabel(isExistAudio: Bool) {
        self.view.addSubview(contentLabel)

        if isExistAudio {
            contentLabel.snp.makeConstraints {
                $0.top.equalTo(dreamAudioPlayerView.snp.bottom).offset(Metric.noteLabelTop)
                $0.leading.trailing.equalToSuperview()
            }
        } else {
            contentLabel.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(Metric.noteLabelTop)
                $0.leading.trailing.equalToSuperview()
            }
        }

        self.contentLabel.text = content
        contentLabel.addLabelSpacing(kernValue: -0.14)
    }

    private func setAudioPlayer() {
        self.view.addSubview(dreamAudioPlayerView)

        dreamAudioPlayerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Metric.audioViewTop)
            $0.leading.trailing.equalToSuperview().inset(Metric.audioViewLeadingTrailing)
        }
    }

    private func setPlaceHolder(isExistAudio: Bool) {
        self.view.addSubview(placeHolder)

        if isExistAudio {
            placeHolder.snp.makeConstraints {
                $0.top.equalTo(dreamAudioPlayerView.snp.bottom).offset(Metric.noteLabelTop)
                $0.leading.trailing.equalToSuperview()
            }
        } else {
            placeHolder.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(Metric.noteLabelTop)
                $0.leading.trailing.equalToSuperview()
            }
        }
    }
}
