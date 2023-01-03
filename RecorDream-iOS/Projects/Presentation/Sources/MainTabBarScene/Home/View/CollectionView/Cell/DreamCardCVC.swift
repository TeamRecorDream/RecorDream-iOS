//
//  DreamCardCVC.swift
//
//  Created by 김수연 on 2022/10/24.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import Domain
import RD_Core
import RD_DSKit

final class DreamCardCVC: UICollectionViewCell, UICollectionViewRegisterable {

    // MARK: - Properties

    static var isFromNib: Bool = false

    private enum Metric {
        static let emotionImageSize = 85.f

        static let emotionImageTop = 37.f
        static let dateLabelTop = 18.f
        static let contentSpacing = 8.f
        static let contentLeadingTrailing = 22.f

        static let genreStackSpacing = 4.f
        static let genreStackHeight = 21.f
        static let noteLabelHeight = 114.f
    }
    

    // MARK: - UI Components

    private var backgroundImage = UIImageView()

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


    // MARK: - View Life Cycles

    override func prepareForReuse() {
        super.prepareForReuse()
        self.setAttributesForReuse()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
        self.setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI & Layout

    private func setUI() {
        self.backgroundColor = .none
        titleLabel.addLabelSpacing(kernValue: -0.28)
        noteLabel.addLabelSpacing(kernValue: -0.12)
    }

    private func setLayout() {
        self.addSubviews(backgroundImage, emotionImageView, dateLabel, titleLabel, genreStackView, noteLabel)

        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        emotionImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Metric.emotionImageTop)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(Metric.emotionImageSize)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(emotionImageView.snp.bottom).offset(Metric.dateLabelTop)
            $0.centerX.equalToSuperview()
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

    func setData(model: HomeEntity.Record) {
        backgroundImage.image = setEmotionImage(emotion: model.emotion)[0]
        emotionImageView.image = setEmotionImage(emotion: model.emotion)[1]

        dateLabel.text = model.date
        titleLabel.text = model.title
        noteLabel.text = model.content

        if genreStackView.subviews.isEmpty {
            model.genres.forEach {
                genreStackView.addArrangedSubview(DreamGenreTagView(type: .home, genre: $0))
            }
        }
    }

    func setAttributesForReuse() {
        self.backgroundImage.image = nil
        self.emotionImageView.image = nil
        self.dateLabel.text = nil
        self.titleLabel.text = nil
        self.noteLabel.text = nil
        self.genreStackView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
    }

    private func setEmotionImage(emotion: Int) -> [UIImage] {
        switch emotion {
        case 1:
            return [RDDSKitAsset.Images.cardMYellow.image, RDDSKitAsset.Images.feelingLJoy.image]
        case 2:
            return [RDDSKitAsset.Images.cardMBlue.image, RDDSKitAsset.Images.feelingLSad.image]
        case 3:
            return [RDDSKitAsset.Images.cardMRed.image, RDDSKitAsset.Images.feelingLScary.image]
        case 4:
            return [RDDSKitAsset.Images.cardMPurple.image, RDDSKitAsset.Images.feelingLStrange.image]
        case 5:
            return [RDDSKitAsset.Images.cardMPink.image, RDDSKitAsset.Images.feelingLShy.image]
        default:
            return [RDDSKitAsset.Images.cardMWhite.image, RDDSKitAsset.Images.feelingLBlank.image]
        }
    }
}
