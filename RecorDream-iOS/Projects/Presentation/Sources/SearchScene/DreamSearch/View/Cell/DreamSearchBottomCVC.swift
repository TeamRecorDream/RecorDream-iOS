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
        iv.image = RDDSKitAsset.Images.rdgoroMark.image
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override func setupView() {
        self.addSubview(rogoImageView)
    }
    override func setupConstraint() {
        rogoImageView.snp.makeConstraints { make in
            make.width.equalTo(124.adjustedWidth)
            make.height.equalTo(22.adjustedHeight)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(76)
        }
    }
}
