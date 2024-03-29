//
//  DreamSearchHeaderCVC.swift
//  Presentation
//
//  Created by 정은희 on 2022/10/11.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import Domain
import RD_DSKit

final class DreamSearchHeaderCVC: UICollectionReusableView {
    private lazy var countLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = RDDSKitColors.Color.white
        lb.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 12)
        return lb
    }()
    private lazy var lineView: UIView = {
        let v = UIView()
        v.backgroundColor = RDDSKitColors.Color.white.withAlphaComponent(0.1)
        return v
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
        self.addSubviews(countLabel, lineView)
    }
    private func setupConstraint() {
        self.countLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(1)
        }
        self.lineView.snp.makeConstraints { make in
            make.height.equalTo(1.adjustedHeight)
            make.centerY.equalTo(countLabel)
            make.leading.equalTo(countLabel.snp.trailing).offset(7)
            make.trailing.equalToSuperview().offset(21)
        }
    }
}

extension DreamSearchHeaderCVC {
    func configureCell(counts: Int) {
        self.countLabel.text = "\(counts)개의 기록"
    }
}
