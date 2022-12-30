//
//  DreamSearchBottomCVC.swift
//  Presentation
//
//  Created by 정은희 on 2022/10/11.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_DSKit

final class DreamSearchBottomCVC: UICollectionReusableView {
    private lazy var rogoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = RDDSKitAsset.Images.rdHomeLogo.image
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .white.withAlphaComponent(0.4)
        return iv
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
        self.addSubview(rogoImageView)
    }
    private func setupConstraint() {
        self.rogoImageView.snp.makeConstraints { make in
            make.width.equalTo(124.adjustedWidth)
            make.height.equalTo(22.adjustedHeight)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(76)
        }
    }
}
