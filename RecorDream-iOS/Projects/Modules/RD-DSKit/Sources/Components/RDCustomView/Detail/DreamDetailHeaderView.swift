//
//  DreamDetailHeaderView.swift
//  RD-DSKit
//
//  Created by 김수연 on 2022/12/13.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

public final class DreamDetailHeaderView: UIView {

    private enum Metric {
        static let closeButtonLeading = 20.f
        static let closeButtonSize = 24.f

        static let moreButtonSize = 24.f
        static let moreButtontrailing = 21.f
    }

    // MARK: - UI Components

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(RDDSKitAsset.Images.icnClose.image, for: .normal)
        return button
    }()

    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(RDDSKitAsset.Images.icnMore.image, for: .normal)
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 16)
        label.textColor = RDDSKitAsset.Colors.white02.color
        label.text = "기록 상세보기"
        return label
    }()

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
        self.addSubviews(closeButton, titleLabel, moreButton)

        closeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Metric.closeButtonLeading)
            $0.width.height.equalTo(Metric.closeButtonSize)
        }

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }

        moreButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Metric.moreButtontrailing)
            $0.width.height.equalTo(Metric.moreButtonSize)
        }
    }
}
