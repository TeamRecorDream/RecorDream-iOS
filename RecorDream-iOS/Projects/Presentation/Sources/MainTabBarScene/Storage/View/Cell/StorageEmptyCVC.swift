//
//  StorageEmptyCVC.swift
//  Presentation
//
//  Created by 정은희 on 2022/12/08.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_DSKit

final class StorageEmptyCVC: UICollectionViewCell {
    // MARK: - UI Components
    private lazy var emptyLabel: UILabel = {
        let lb = UILabel()
        lb.font = RDDSKitFontFamily.Pretendard.medium.font(size: 16)
        lb.text = "아직 기록된 꿈이 없어요."
        lb.textColor = RDDSKitColors.Color(white: 1.0, alpha: 0.4)
        return lb
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
    
    // MARK: - Functions
    private func setupView() {
        self.addSubview(emptyLabel)
    }
    private func setupConstraint() {
        emptyLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
