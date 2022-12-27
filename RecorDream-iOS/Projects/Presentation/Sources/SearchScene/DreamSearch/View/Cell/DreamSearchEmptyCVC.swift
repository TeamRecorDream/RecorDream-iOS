//
//  DreamSearchEmptyCVC.swift
//  Presentation
//
//  Created by 정은희 on 2022/10/11.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_DSKit

final class DreamSearchEmptyCVC: UICollectionViewCell {
    private lazy var emptyLabel: UILabel = {
        let lb = UILabel()
        lb.font = RDDSKitFontFamily.Pretendard.medium.font(size: 16)
        lb.text = "찾으시는 기록이 없어요."
        lb.textColor = RDDSKitColors.Color(white: 1.0, alpha: 0.4)
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
        self.setupConstraint()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(emptyLabel)
    }
    private func setupConstraint() {
        self.emptyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
