//
//  StorageExistCVC.swift
//  Presentation
//
//  Created by 정은희 on 2022/12/08.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_Core
import RD_DSKit

final class StorageExistCVC: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
    public static var isFromNib: Bool = false
    private var emotion = 0
    
    // MARK: - UI Components
    private var layoutType: RDCollectionViewFlowLayout.CollectionDisplay = .grid
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
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.genreStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    // MARK: - Functions
    private func setupView() {
        self.addSubviews(backgroundImageView, emotionImageView, dateLabel, titleLabel, genreStackView)
        self.backgroundColor = .none
        self.titleLabel.addLabelSpacing(kernValue: -0.22)
    }
    private func removeView() {
        [backgroundImageView, emotionImageView, dateLabel, titleLabel, genreStackView]
            .forEach { view in
                view.removeFromSuperview()
            }
    }
    public func setupConstraint(layoutType: RDCollectionViewFlowLayout.CollectionDisplay) {
        removeView()
        setupView()
        
        self.backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        switch layoutType {
        case .list:
            self.emotionImageView.snp.makeConstraints {
                $0.top.equalToSuperview().offset(21)
                $0.leading.equalToSuperview().inset(32)
                $0.size.equalTo(46)
            }
            self.dateLabel.snp.makeConstraints {
                $0.top.equalToSuperview().offset(12)
                $0.leading.equalTo(emotionImageView.snp.trailing).offset(24)
            }
            self.titleLabel.snp.makeConstraints {
                $0.top.equalTo(dateLabel.snp.bottom).offset(3)
                $0.leading.equalTo(dateLabel)
            }
            self.genreStackView.snp.makeConstraints {
                $0.height.equalTo(30)
                $0.top.equalTo(titleLabel.snp.bottom).offset(3)
                $0.leading.equalTo(dateLabel)
            }
        case .grid:
            self.emotionImageView.snp.makeConstraints {
                $0.top.equalToSuperview().inset(23)
                $0.centerX.equalToSuperview().inset(52)
                $0.size.equalTo(60)
            }
            self.dateLabel.snp.makeConstraints {
                $0.top.equalTo(emotionImageView.snp.bottom).offset(14)
                $0.centerX.equalToSuperview()
            }
            self.titleLabel.snp.makeConstraints {
                $0.top.equalTo(dateLabel.snp.bottom).offset(8)
                $0.centerX.equalTo(emotionImageView)
            }
            self.genreStackView.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(8)
                $0.centerX.equalToSuperview()
                $0.height.equalTo(16)
                $0.bottom.equalToSuperview().inset(22)
            }
        }
    }
}

extension StorageExistCVC {
    func setData(emotion: Int, date: String, title: String, tag: [Int], layoutType: RDCollectionViewFlowLayout.CollectionDisplay) {
        switch layoutType {
        case .grid:
            self.backgroundImageView.image = self.setEmotionImage(emotion: emotion)[1]
        case .list:
            self.backgroundImageView.image = self.setEmotionImage(emotion: emotion).first
        }
        self.emotionImageView.image = self.setEmotionImage(emotion: emotion).last
        self.dateLabel.text = date
        self.titleLabel.text = title
        let hasNoTag = tag.first == 0
        if hasNoTag {
            self.genreStackView.addArrangedSubview(DreamGenreTagView(type: .storage,
                                                                     genre: "# 아직 설정되지 않았어요"))
        } else {
            tag.forEach { genreType in
                self.genreStackView.addArrangedSubview(DreamGenreTagView(type: .storage,
                                                                         genre: Section.genreTitles[genreType-1]))
            }
        }
        self.emotion = emotion
        self.layoutSubviews()
    }
    private func setEmotionImage(emotion: Int) -> [UIImage] {
        switch emotion {
        case 1:
            return [RDDSKitAsset.Images.listYellow.image, RDDSKitAsset.Images.cardSYellow.image ,RDDSKitAsset.Images.feelingMJoy.image]
        case 2:
            return [RDDSKitAsset.Images.listBlue.image, RDDSKitAsset.Images.cardSBlue.image, RDDSKitAsset.Images.feelingMSad.image]
        case 3:
            return [RDDSKitAsset.Images.listRed.image, RDDSKitAsset.Images.cardSRed.image, RDDSKitAsset.Images.feelingMScary.image]
        case 4:
            return [RDDSKitAsset.Images.listPurple.image, RDDSKitAsset.Images.cardSPurple.image, RDDSKitAsset.Images.feelingMStrange.image]
        case 5:
            return [RDDSKitAsset.Images.listPink.image, RDDSKitAsset.Images.cardSPink.image, RDDSKitAsset.Images.feelingMShy.image]
        case 6:
            return [RDDSKitAsset.Images.listWhite.image, RDDSKitAsset.Images.cardSWhite.image, RDDSKitAsset.Images.feelingLBlank.image]
        default:
            return [RDDSKitAsset.Images.listWhite.image, RDDSKitAsset.Images.cardSWhite.image, RDDSKitAsset.Images.feelingMBlank.image]
        }
    }
}
