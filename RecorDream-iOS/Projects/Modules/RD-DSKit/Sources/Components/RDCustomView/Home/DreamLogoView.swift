//
//  DreamLogoView.swift
//  RD-DSKit
//
//  Created by 김수연 on 2022/10/23.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

public final class DreamLogoView: UIView {

    // MARK: - UI Components

    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = RDDSKitAsset.Images.rdHomeLogo.image
        imageView.tintColor = .white
        return imageView
    }()

    public lazy var mypageButton: UIButton = {
        let button = UIButton()
        button.setImage(RDDSKitAsset.Images.icnMypageS.image, for: .normal)
        return button
    }()

    public lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(RDDSKitAsset.Images.icnSearch.image, for: .normal)
        return button
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
        self.addSubviews(logoImage, mypageButton, searchButton)

        let adjustedInset = 16.adjusted

        logoImage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(adjustedInset)
            $0.top.bottom.equalToSuperview()
        }

        mypageButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(adjustedInset)
            $0.top.bottom.equalToSuperview()
        }

        searchButton.snp.makeConstraints {
            $0.trailing.equalTo(mypageButton.snp.leading).offset(-4)
            $0.top.bottom.equalToSuperview()
        }
    }
}

extension Reactive where Base: DreamLogoView {
    public var mypageButtonTapped: ControlEvent<Void> {
        return base.mypageButton.rx.tap
    }
    public var searchButtonTapped: ControlEvent<Void> {
        return base.searchButton.rx.tap
    }
}
