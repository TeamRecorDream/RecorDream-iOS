//
//  VoiceNoticeView.swift
//  RD-DSKit
//
//  Created by 김수연 on 2023/01/08.
//  Copyright © 2023 RecorDream-iOS. All rights reserved.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

public final class VoiceNoticeView: UIView {

    // MARK: - UI Components

    private let micImage = UIImageView(image: RDDSKitAsset.Images.icnMic.image)

    private let onlyVoiceExistLabel: UILabel = {
        let label = UILabel()
        label.text = "음성만 기록되어 있어요"
        label.font = RDDSKitFontFamily.Pretendard.regular.font(size: 12)
        label.textColor = RDDSKitAsset.Colors.white02.color
        return label
    }()

    private enum Metric {
        static let micSize = 24.f
        static let contentSpacing = 4.f

        static let voiceLabelTopBottom = 3.f
    }

    // MARK: - View Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI & Layouts

    private func setUI() {
        self.backgroundColor = .none
    }

    private func setLayout() {
        self.addSubviews(micImage, onlyVoiceExistLabel)

        micImage.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.width.equalTo(Metric.micSize)
        }

        onlyVoiceExistLabel.snp.makeConstraints {
            $0.leading.equalTo(micImage.snp.trailing).inset(Metric.contentSpacing)
            $0.top.bottom.equalToSuperview().inset(Metric.voiceLabelTopBottom)
        }
    }
}
