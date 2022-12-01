//
//  RDLoginButton.swift
//  RD-DSKit
//
//  Created by 정은희 on 2022/12/01.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import SnapKit

public class RDLoginButton: UIButton {
    public enum FlatformType: String {
        case kakao = "kakao"
        case apple = "apple"
    }
    
    public let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    // MARK: - Initialization
    public convenience init(flatform: FlatformType, title: String) {
        self.init(frame: .zero)
        
        self.setupView(at: flatform, for: title)
        self.setupConstraint()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions
extension RDLoginButton {
    private func setupView(at flatform: FlatformType, for title: String) {
        switch flatform {
        case .kakao:
            self.iconImageView.image = RDDSKitAsset.Images.kakaotalk.image
        case .apple:
            self.iconImageView.image = RDDSKitAsset.Images.apple.image
        }
        
        self.backgroundColor = .white.withAlphaComponent(0.05)
        self.makeRoundedWithBorder(radius: 12, borderColor: UIColor(white: 1.0, alpha: 0.1).cgColor)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = RDDSKitFontFamily.Pretendard.regular.font(size: 14)
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.textColor = .white
        
        self.addSubview(iconImageView)
    }
    private func setupConstraint() {
        self.iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.centerY.equalToSuperview()
        }
    }
}
