//
//  DreamShareView.swift
//  Presentation
//
//  Created by 김수연 on 2023/02/01.
//  Copyright © 2023 RecorDream-iOS. All rights reserved.
//

import UIKit

import RD_DSKit

import SnapKit
import RxSwift
import RxCocoa

public final class DreamShareView: UIView {

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    private enum Metric {
        static let logoViewTop = 159.adjustedH
        static let logoViewLeadingTrailing = 50.adjustedWidth

        static let cardTop = 22.adjustedH
        static let cardLeadingTrailing = 34.adjustedWidth
        static let cardHeight = 470.adjustedH

        static let emotionImageWidth = 85.adjustedWidth
        static let emotionImageHeight = 85.adjustedH

        static let emotionImageTop = 37.adjustedH
        static let dateLabelTop = 18.adjustedH
        static let contentSpacing = 8.adjustedH
        static let contentLeadingTrailing = 22.adjustedWidth
        static let dateLabelHeight = 17.f

        static let genreStackSpacing = 4.f
        static let genreStackHeight = 21.adjustedH
        static let noteLabelHeight = 200.adjustedH

        static let voiceNoticeViewWidth = 137.adjustedWidth
        static let voiceTopSpacing = 9.adjustedH
        static let voiceNoticeViewHeight = 24.adjustedH
    }

    // MARK: - UI Components

    private let backgroundView = UIImageView(image: RDDSKitAsset.Images.instaBackground.image)
    let instaLogoView = UIImageView(image: RDDSKitAsset.Images.instaRogo.image)

    private let cardView = UIImageView(image: RDDSKitAsset.Images.instaCardRed.image)

    private var emotionImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    private var dateLabel: UILabel = {
        let label = UILabel()
        label.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 12)
        label.textAlignment = .center
        label.textColor = RDDSKitColors.Color.white
        return label
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 14)
        label.textAlignment = .left
        label.textColor = RDDSKitColors.Color.white
        label.numberOfLines = 2
        return label
    }()

    private var genreStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        stack.spacing = Metric.genreStackSpacing
        return stack
    }()

    private var noteLabel: UILabel = {
        let label = UILabel()
        label.font = RDDSKitFontFamily.Pretendard.regular.font(size: 12)
        label.textAlignment = .left
        label.textColor = RDDSKitColors.Color.white
        label.numberOfLines = 0
        return label
    }()

    // MARK: - View Life Cycle

    public init() {
        super.init(frame: .zero)

        self.setUI()
        self.setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI & Layout

    private func setUI() {
        self.backgroundColor = RDDSKitAsset.Colors.dark.color
    }

    private func setLayout() {
        self.addSubviews(backgroundView, instaLogoView, cardView)

        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        instaLogoView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Metric.logoViewTop)
            $0.leading.trailing.equalToSuperview().inset(Metric.logoViewLeadingTrailing)
        }

        cardView.snp.makeConstraints {
            $0.top.equalTo(instaLogoView.snp.bottom).offset(Metric.cardTop)
            $0.height.equalTo(Metric.cardHeight)
            $0.leading.trailing.equalToSuperview().inset(Metric.cardLeadingTrailing)
        }

        cardView.addSubviews(emotionImageView, dateLabel, titleLabel, genreStackView, noteLabel)

        emotionImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Metric.emotionImageTop)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Metric.emotionImageHeight)
            $0.width.equalTo(Metric.emotionImageWidth)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(emotionImageView.snp.bottom).offset(Metric.dateLabelTop)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Metric.dateLabelHeight)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(Metric.contentSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.contentLeadingTrailing)
        }

        genreStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Metric.contentSpacing)
            $0.leading.equalToSuperview().inset(Metric.contentLeadingTrailing)
            $0.height.equalTo(Metric.genreStackHeight)
        }

        noteLabel.snp.makeConstraints {
            $0.top.equalTo(genreStackView.snp.bottom).offset(Metric.contentSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.contentLeadingTrailing)
            $0.height.equalTo(Metric.noteLabelHeight)
        }
    }

    func setData(emotion: Int, date: String, title: String, content: String, genre: [String]) {
        cardView.image = setEmotionImage(emotion: emotion)[0]
        emotionImageView.image = setEmotionImage(emotion: emotion)[1]

        dateLabel.text = date
        titleLabel.text = title
        noteLabel.text = content

        if genreStackView.subviews.isEmpty {
            genre.forEach {
                genreStackView.addArrangedSubview(DreamGenreTagView(type: .detail, genre: $0))
            }
        }
        titleLabel.addLabelSpacing(kernValue: -0.28)
        noteLabel.addLabelSpacing(kernValue: -0.12)
    }

    private func setEmotionImage(emotion: Int) -> [UIImage] {
        switch emotion {
        case 1:
            return [RDDSKitAsset.Images.instaCardYellow.image, RDDSKitAsset.Images.feelingLJoy.image]
        case 2:
            return [RDDSKitAsset.Images.instaCardBlue.image, RDDSKitAsset.Images.feelingLSad.image]
        case 3:
            return [RDDSKitAsset.Images.instaCardRed.image, RDDSKitAsset.Images.feelingLScary.image]
        case 4:
            return [RDDSKitAsset.Images.instaCardPurple.image, RDDSKitAsset.Images.feelingLStrange.image]
        case 5:
            return [RDDSKitAsset.Images.instaCardPink.image, RDDSKitAsset.Images.feelingLShy.image]
        default:
            return [RDDSKitAsset.Images.instaCardWhite.image, RDDSKitAsset.Images.feelingLBlank.image]
        }
    }
}
