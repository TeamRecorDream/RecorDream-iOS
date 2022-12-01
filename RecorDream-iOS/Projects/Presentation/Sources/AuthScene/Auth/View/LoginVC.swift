//
//  LoginVC.swift
//  Presentation
//
//  Created by 정은희 on 2022/12/01.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_DSKit

import RxSwift
import RxCocoa
import SnapKit

public final class LoginVC: UIViewController {
    
    // MARK: - UI Components
    private let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = RDDSKitAsset.Images.splashBackground.image
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = RDDSKitAsset.Images.rdSplashLogo.image
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private let kakaoLoginButton = RDLoginButton(flatform: .kakao, title: "카카오로 시작하기")
    private let appleLoginButton = RDLoginButton(flatform: .apple, title: "Apple로 시작하기")
    private let descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.font = RDDSKitFontFamily.Pretendard.regular.font(size: 12)
        lb.text = "로그인 후 이용이 가능합니다."
        lb.textAlignment = .center
        lb.textColor = .white.withAlphaComponent(0.4)
        lb.sizeToFit()
        return lb
    }()

    // MARK: - View Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupConstraint()
    }
    
}

// MARK: - Extensions
extension LoginVC: AutoControllable {
    func setupView() {
        self.view.addSubview(backgroundImageView)
        self.backgroundImageView.addSubviews(logoImageView, kakaoLoginButton, appleLoginButton, descriptionLabel)
    }
    
    func setupConstraint() {
        self.backgroundImageView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
        self.logoImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        self.kakaoLoginButton.snp.makeConstraints { make in
            make.width.equalTo(343.adjustedWidth)
            make.height.equalTo(52.adjustedHeight)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(614)
        }
        self.appleLoginButton.snp.makeConstraints { make in
            make.width.height.equalTo(kakaoLoginButton)
            make.centerX.equalToSuperview()
            make.top.equalTo(kakaoLoginButton.snp.bottom).offset(8)
        }
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(appleLoginButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
}
