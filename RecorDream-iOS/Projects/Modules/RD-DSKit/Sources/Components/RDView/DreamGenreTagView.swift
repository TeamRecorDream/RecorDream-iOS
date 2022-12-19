//
//  DreamGenreTagView.swift
//  RD-DSKit
//
//  Created by 김수연 on 2022/10/24.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import HeeKit
import SnapKit

public final class DreamGenreTagView: UIView {

    // MARK: - Properties

    public enum CardType {
        case home
        case detail
        case search
        case storage
    }

    public var cardType: CardType = .home

    // MARK: - UI Components

    public let genreNameLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.sizeToFit()
        lb.textColor = RDDSKitAsset.Colors.white01.color
        return lb
    }()

    // MARK: - View Life Cycle

    public convenience init(type: CardType, genre: String) {
        self.init(frame: .zero)

        self.cardType = type
        self.genreNameLabel.text = genre
        self.setupView()
        self.setUI()
        self.setupConstraint()
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DreamGenreTagView: Presentable {
    public func setupView() {
        self.backgroundColor = RDDSKitAsset.Colors.white05.color
        self.makeRounded(radius: 3)
        self.addSubview(genreNameLabel)
    }

    public func setUI() {
        switch cardType {
        case .home, .detail:
            self.genreNameLabel.font = RDDSKitFontFamily.Pretendard.medium.font(size: 10)
        case .search, .storage:
            self.genreNameLabel.font = RDDSKitFontFamily.Pretendard.medium.font(size: 8)
        }
    }

    public func setupConstraint() {
        self.addSubview(genreNameLabel)

        genreNameLabel.snp.makeConstraints { make in
            switch cardType {
            case .home, .detail:
                make.edges.equalToSuperview().inset(4)
            case .search, .storage:
                make.centerY.equalToSuperview().inset(3)
                make.leading.trailing.equalToSuperview().offset(4)
            }
        }
    }
}
