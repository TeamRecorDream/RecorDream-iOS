//
//  DreamSearchEmptyView.swift
//  Presentation
//
//  Created by 정은희 on 2022/10/11.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_Core
import RD_DSKit

extension UICollectionView {
    func setEmptyView(message: String? = nil, image: UIImage? = nil) {
        let emptyView: UIView = {
            let v = UIView()
            v.frame = CGRect(x: self.center.x, y: self.center.y, width: self.bounds.width, height: self.bounds.height)
            return v
        }()
        let emptyLabel: UILabel = {
            let lb = UILabel()
            lb.font = RDDSKitFontFamily.Pretendard.medium.font(size: 16)
            lb.text = message ?? "찾으시는 기록이 없어요."
            lb.textColor = RDDSKitColors.Color(white: 1.0, alpha: 0.4)
            return lb
        }()
        let logoImageView: UIImageView = {
            let iv = UIImageView()
            iv.image = image ?? RDDSKitAsset.Images.rdHomeLogo.image
            iv.contentMode = .scaleAspectFit
            iv.tintColor = .white.withAlphaComponent(0.4)
            return iv
        }()
        
        // MARK: - Render
        [emptyLabel, logoImageView].forEach { emptyView.addSubview($0) }
        
        emptyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(208)
        }
        logoImageView.snp.makeConstraints { make in
            make.width.equalTo(124.adjustedWidth)
            make.height.equalTo(22.adjustedHeight)
            make.centerX.equalTo(emptyLabel)
            make.top.equalTo(emptyLabel.snp.bottom).offset(282)
        }
        self.backgroundView = emptyView
    }
    
    // MARK: - Empty
    func restore() {
        self.backgroundView = nil
    }
}
