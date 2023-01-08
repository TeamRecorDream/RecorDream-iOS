//
//  DreamShareVC.swift
//  Presentation
//
//  Created by 김수연 on 2023/01/08.
//  Copyright © 2023 RecorDream-iOS. All rights reserved.
//

import UIKit

import Domain
import RD_DSKit

import RxSwift
import SnapKit

public class DreamShareVC: UIViewController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    public var viewModel: DreamShareViewModel!
    public var factory: ViewControllerFactory!

    private enum Metric {
        static let logoViewTop = 159.f
        static let logoViewLeadingTrailing = 50.f

        static let cardTop = 22.f
        static let cardLeadingTrailing = 34.f

        static let emotionImageSize = 85.f

        static let emotionImageTop = 37.f
        static let dateLabelTop = 18.f
        static let dateLabelHeight = 17.f
        static let contentSpacing = 8.f
        static let contentLeadingTrailing = 29.f

        static let genreStackSpacing = 4.f
        static let genreStackHeight = 21.f
        static let noteLabelHeight = 200.f
    }
  
    // MARK: - UI Components

    private let backgroundView = UIImageView(image: RDDSKitAsset.Images.instaBackground.image)
    private let instaLogoView = UIImageView(image: RDDSKitAsset.Images.instaRogo.image)

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
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        self.setData(model: DreamDetailEntity(recordId: "", date: "2023/01/08", title: "더미 타이틀", content: "더미 내용", emotion: 1, genre: ["더미장르"], note: "노트", voiceUrl: nil))

        self.setUI()
        self.setLayout()
        self.bindViewModels()
    }

    // MARK: - UI & Layout

    private func setUI() {
        self.view.backgroundColor = RDDSKitAsset.Colors.dark.color
    }

    private func setLayout() {
        self.view.addSubviews(backgroundView, instaLogoView, cardView)

        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        instaLogoView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Metric.logoViewTop)
            $0.leading.trailing.equalToSuperview().inset(Metric.logoViewLeadingTrailing)
        }

        cardView.snp.makeConstraints {
            $0.top.equalTo(instaLogoView.snp.bottom).offset(Metric.cardTop)
            $0.leading.trailing.equalToSuperview().inset(Metric.cardLeadingTrailing)
        }

        cardView.addSubviews(emotionImageView, dateLabel, titleLabel, genreStackView, noteLabel)

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

    func setData(model: DreamDetailEntity) {
        cardView.image = setEmotionImage(emotion: model.emotion)[0]
        emotionImageView.image = setEmotionImage(emotion: model.emotion)[1]

        dateLabel.text = model.date
        titleLabel.text = model.title
        noteLabel.text = model.content

        if genreStackView.subviews.isEmpty {
            model.genre.forEach {
                genreStackView.addArrangedSubview(DreamGenreTagView(type: .detail, genre: $0))
            }
        }
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

// MARK: - Methods

extension DreamShareVC {
  
    private func bindViewModels() {
        let input = DreamShareViewModel.Input()
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    }

}
