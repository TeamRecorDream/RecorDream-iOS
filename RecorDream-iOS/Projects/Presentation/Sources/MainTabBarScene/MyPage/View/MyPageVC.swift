//
//  MyPageVC.swift
//  PresentationTests
//
//  Created by Junho Lee on 2022/10/09.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_DSKit

import RxSwift
import SnapKit

public class MyPageVC: UIViewController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    public var viewModel: MyPageViewModel!
  
    // MARK: - UI Components
    
    private let naviBar = RDNaviBar()
        .rightButtonImage(RDDSKitAsset.Images.icnBack.image)
        .title("마이페이지")
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = RDDSKitAsset.Images.icnMypage.image
        return iv
    }()
    
    private let nickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 16.adjusted)
        label.textColor = .white
        label.sizeToFit()
        return label
    }()
    
    private let editButton: UIButton = {
        let bt = UIButton()
        bt.setImage(RDDSKitAsset.Images.icnEdit.image, for: .normal)
        return bt
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "sample@naver.com"
        label.font = RDDSKitFontFamily.Pretendard.regular.font(size: 12.adjusted)
        label.textColor = .white.withAlphaComponent(0.5)
        label.sizeToFit()
        return label
    }()
  
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setLayout()
        self.bindViewModels()
    }
}

// MARK: - UI & Layouts

extension MyPageVC {
    private func setUI() {
        self.view.backgroundColor = RDDSKitAsset.Colors.dark.color
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setLayout() {
        self.view.addSubviews(naviBar, profileImageView, nickNameLabel,
                              editButton, emailLabel)
        
        naviBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(36)
            make.width.height.equalTo(90.adjusted)
            make.centerX.equalToSuperview()
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        editButton.snp.makeConstraints { make in
            make.leading.equalTo(nickNameLabel.snp.trailing).offset(3)
            make.centerY.equalTo(nickNameLabel.snp.centerY)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - Methods

extension MyPageVC {
    
}

// MARK: - Bind

extension MyPageVC {
  
    private func bindViewModels() {
        let input = MyPageViewModel.Input()
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    }

}
