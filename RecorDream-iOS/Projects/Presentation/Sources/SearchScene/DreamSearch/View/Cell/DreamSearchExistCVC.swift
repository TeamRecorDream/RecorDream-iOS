//
//  DreamSearchExistCVC.swift
//  Presentation
//
//  Created by 정은희 on 2022/12/30.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import UIKit

import RD_Core
import RD_DSKit

final class DreamSearchExistCVC: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
    public static var isFromNib: Bool = false
    
    // MARK: - UI Components
    private var backgroundImageView = UIImageView()
    private var emotionImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.font = RDDSKitFontFamily.Pretendard.medium.font(size: 10)
        label.textAlignment = .left
        label.textColor = RDDSKitColors.Color.white
        return label
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = RDDSKitFontFamily.Pretendard.regular.font(size: 11)
        label.textAlignment = .left
        label.textColor = RDDSKitColors.Color.white
        label.numberOfLines = 2
        return label
    }()
    private var genreStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .leading
        sv.distribution = .equalSpacing
        sv.spacing = 4
        return sv
    }()
    
    // MARK: - View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupView()
        self.setupConstraint()
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        self.genreStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}

// MARK: - Extensions
extension DreamSearchExistCVC {
    private func setupView() {
        self.addSubviews(backgroundImageView, emotionImageView, dateLabel, titleLabel, genreStackView)
        self.makeRounded(radius: 20)
        self.backgroundColor = .none
        self.titleLabel.addLabelSpacing(kernValue: -0.22)
    }
    private func setupConstraint() {
        self.backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.emotionImageView.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.top).offset(21)
            make.leading.equalTo(backgroundImageView.snp.leading).inset(32)
            make.size.equalTo(46)
        }
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.top).offset(12)
            make.leading.equalTo(emotionImageView.snp.trailing).offset(24)
        }
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(3)
            make.leading.equalTo(emotionImageView.snp.trailing).offset(24)
        }
        self.genreStackView.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.leading.equalToSuperview().offset(102)
        }
    }
    func setData(emotion: Int, date: String, title: String, genre: [Int]) {
        self.backgroundImageView.image = self.setEmotionImageView(emotion: emotion).first
        self.emotionImageView.image = self.setEmotionImageView(emotion: emotion).last
        self.titleLabel.text = title
        self.dateLabel.text = date
        let hasNoTag = genre.first == 0
        if hasNoTag {
            self.genreStackView.addArrangedSubview(DreamGenreTagView(type: .storage,
                                                                     genre: "# 아직 설정되지 않았어요"))
        } else {
            genre.forEach { genreType in
                self.genreStackView.addArrangedSubview(DreamGenreTagView(type: .storage,
                                                                         genre: Section.genreTitles[genreType-1]))
            }
        }
    }
    private func setEmotionImageView(emotion: Int) -> [UIImage] {
        switch emotion {
        case 1:
            return [RDDSKitAsset.Images.listYellow.image, RDDSKitAsset.Images.feelingMJoy.image]
        case 2:
            return [RDDSKitAsset.Images.listBlue.image, RDDSKitAsset.Images.feelingMSad.image]
        case 3:
            return [RDDSKitAsset.Images.listRed.image, RDDSKitAsset.Images.feelingMScary.image]
        case 4:
            return [RDDSKitAsset.Images.listPurple.image, RDDSKitAsset.Images.feelingMStrange.image]
        case 5:
            return [RDDSKitAsset.Images.listPink.image, RDDSKitAsset.Images.feelingMShy.image]
        case 6:
            return [RDDSKitAsset.Images.listWhite.image, RDDSKitAsset.Images.feelingLBlank.image]
        default:
            return [RDDSKitAsset.Images.listWhite.image, RDDSKitAsset.Images.feelingMBlank.image]
        }
    }
}
