//
//  DreamSearchExistCVC.swift
//  Presentation
//
//  Created by 정은희 on 2022/10/11.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_DSKit

final class DreamSearchExistCVC: DreamCollectionViewCell {
    // MARK: - UI Components
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = RDDSKitAsset.Images.backgroundBlue.image // ✅
        return iv
    }()
    private lazy var symbolImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = RDDSKitAsset.Images.feelingSJoy.image // ✅
        return iv
    }()
    private lazy var labelStackView: UIStackView = {
        let sv = UIStackView()
        sv.alignment = .leading
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.spacing = 3
        return sv
    }()
    private lazy var dayLabel: UILabel = {
        let lb = UILabel()
        lb.font = RDDSKitFontFamily.Pretendard.medium.font(size: 10)
        lb.text = "2022/06/26 SUN"
        lb.textAlignment = .left
        lb.textColor = RDDSKitColors.Color.white
        return lb
    }()
    private lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = RDDSKitFontFamily.Pretendard.regular.font(size: 11)
        lb.lineBreakMode = .byWordWrapping
        lb.numberOfLines = 2
        lb.text = "오늘 친구들이랑 피자 먹고 진짜 재밌는 일 많은 꿈을 많이 꿨다."
        lb.textAlignment = .left
        lb.textColor = RDDSKitColors.Color.white
        return lb
    }()
    private lazy var genreView: UIView = {
        let v = DreamGenreView(genre: "#로맨스") // ✅
        return v
    }()
    
    // MARK: - Functions
    override func setupView() {
        self.addSubview(backgroundImageView)
        self.backgroundImageView.addSubviews(symbolImageView, labelStackView)
        self.labelStackView.addArrangedSubviews(dayLabel, titleLabel, genreView)
    }
    override func setupConstraint() {
        backgroundImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        symbolImageView.snp.makeConstraints { make in
            make.width.height.equalTo(46)
            make.centerY.equalToSuperview().inset(21)
            make.centerX.equalToSuperview().offset(32)
        }
        labelStackView.snp.makeConstraints { make in
            make.width.equalTo(200.adjustedWidth)
            make.centerY.equalToSuperview().inset(12)
            make.leading.equalTo(symbolImageView.snp.trailing).offset(24)
        }
        dayLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom)
            make.leading.equalToSuperview()
        }
        genreView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalToSuperview()
        }
    }
}

extension DreamSearchExistCVC {
    func configureCell(viewModel: DreamSearchResultViewModel) {
//        self.backgroundImageView
//        self.genreView
    }
}
