//
//  AuthView.swift
//  Presentation
//
//  Created by 정은희 on 2022/12/01.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_DSKit

import SnapKit

final class AuthView: UIView {
    
    // MARK: - UI Components
    private let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = RDDSKitAsset.Images.splashBackground.image
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = RDDSKitAsset.Images.rdSplashLogo.image
        iv.contentMode = .scaleAspectFill
        return iv
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
        self.setupConstraint()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AuthView: AuthControllable {
    func setupView() {
        self.addSubview(backgroundImageView)
        self.backgroundImageView.addSubview(logoImageView)
    }
    func setupConstraint() {
        self.backgroundImageView.snp.makeConstraints { make in
            make.width.height.equalToSuperview().inset(-1)
            make.centerX.centerY.equalToSuperview().inset(-1)
        }
        self.logoImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
