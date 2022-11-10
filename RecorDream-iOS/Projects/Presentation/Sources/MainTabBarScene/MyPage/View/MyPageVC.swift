//
//  MyPageVC.swift
//  PresentationTests
//
//  Created by Junho Lee on 2022/10/09.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import Domain
import RD_Core
import RD_DSKit

import RxSwift
import RxCocoa
import SnapKit

// TODO: Loading Extension 만들기, Loading Event 바인딩하기

public class MyPageVC: UIViewController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    public var viewModel: MyPageViewModel!
    
    private let usernameAlertDismissed = PublishRelay<Void>()
    private let WithdrawalActionTapped = PublishRelay<Void>()
    
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
    
    private let myPageEditableView = MyPageEditableView()
    
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
    
    private let pushSettingView = MyPageInteractionView()
        .viewType(.pushOnOff)
    
    private let timeSettingView = MyPageInteractionView()
        .viewType(.timeSetting)
    
    private let guideLabel: UILabel = {
        let label = UILabel()
        label.text = "설정한 시간에 푸시알림을 통해 꿈을 바로 기록할 수 있어요!"
        label.font = RDDSKitFontFamily.Pretendard.regular.font(size: 12.adjustedH)
        label.textColor = .white.withAlphaComponent(0.4)
        return label
    }()
    
    private let logoutButton: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = RDDSKitAsset.Colors.purple.color
        bt.setTitle("로그아웃", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.titleLabel?.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 16)
        bt.layer.cornerRadius = 15
        return bt
    }()
    
    private let WithdrawalButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("탈퇴하기", for: .normal)
        bt.setUnderline()
        bt.setTitleColor(.white.withAlphaComponent(0.5), for: .normal)
        bt.titleLabel?.font = RDDSKitFontFamily.Pretendard.regular.font(size: 14)
        return bt
    }()
    
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setLayout()
        self.bindViews()
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
        self.view.addSubviews(naviBar, profileImageView, myPageEditableView,
                              editButton, emailLabel, pushSettingView,
                              timeSettingView, guideLabel, logoutButton,
                              WithdrawalButton)
        
        naviBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(36.adjustedH)
            make.width.height.equalTo(90.adjusted)
            make.centerX.equalToSuperview()
        }
        
        myPageEditableView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(8.adjustedH)
            make.centerX.equalToSuperview()
        }
        
        editButton.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(-5.adjusted)
            make.centerY.equalTo(myPageEditableView.snp.centerY)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(myPageEditableView.snp.bottom).offset(5.adjustedH)
            make.centerX.equalToSuperview()
        }
        
        pushSettingView.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(26.adjustedH)
            make.height.equalTo(64.adjustedH)
            make.leading.trailing.equalToSuperview().inset(16.adjusted)
        }
        
        timeSettingView.snp.makeConstraints { make in
            make.top.equalTo(pushSettingView.snp.bottom).offset(18.adjustedH)
            make.height.equalTo(64.adjustedH)
            make.leading.trailing.equalToSuperview().inset(16.adjusted)
        }
        
        guideLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(25.adjusted)
            make.top.equalTo(timeSettingView.snp.bottom).offset(8.adjusted)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16.adjusted)
            make.height.equalTo(50.adjustedH)
            make.bottom.equalTo(WithdrawalButton.snp.top).offset(-12.adjusted)
        }
        
        WithdrawalButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(safeAreaBottomInset() + 18)
        }
        
//        timePickerView.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview()
//            make.height.equalTo(340.adjustedH)
//            make.top.equalToSuperview().inset(UIScreen.main.bounds.height - 340.adjustedH)
//        }
    }
}

// MARK: - Methods

extension MyPageVC {
    
}

// MARK: - Bind

extension MyPageVC {
    
    private func bindViews() {
        self.WithdrawalButton.rx.tap
            .asDriver()
            .drive(onNext: {
                self.showWithdrawalWarningAlert()
            })
            .disposed(by: self.disposeBag)
    }
    
    // TODO: usernameTextField와 keyboardReturn의 Merge, UIDatePicker 뷰 작성 및 이벤트 바인딩
    
    private func bindViewModels() {
        let input = MyPageViewModel.Input(viewDidLoad: Observable.just(()),
                                          editButtonTapped: editButton.rx.tap.asObservable(),
                                          myPageReturnOutput: myPageEditableView.endEditingWithText.asObservable(),
                                          usernameAlertDismissed: self.usernameAlertDismissed.asObservable(),
                                          pushSwitchChagned: pushSettingView.rx.pushSwitchIsOn.asObservable(),
                                          pushTimePicked: Observable.just(""),
                                          logoutButtonTapped: logoutButton.rx.tap.asObservable(),
                                          WithdrawalButtonTapped: WithdrawalActionTapped.asObservable())
        
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
        
        output.myPageDataFetched
            .compactMap { $0 }
            .withUnretained(self)
            .bind { strongSelf, entity in
                strongSelf.fetchMyPageData(model: entity)
            }.disposed(by: self.disposeBag)
        
        output.startUsernameEdit
            .bind(to: self.myPageEditableView.rx.isEditing)
            .disposed(by: self.disposeBag)
        
        output.showAlert
            .bind { self.showUsernameWarningAlert() }
            .disposed(by: self.disposeBag)
    }
    
    private func fetchMyPageData(model: MyPageEntity) {
        self.myPageEditableView.initText = model.userName
        self.emailLabel.text = model.email
    }
    
    private func showUsernameWarningAlert() {
        self.makeAlert(title: "닉네임 변경", message: "1~8자까지 가능합니다.", okAction:  { _ in
            self.usernameAlertDismissed.accept(())
        })
    }
    
    private func showWithdrawalWarningAlert() {
        self.makeAlertWithCancelDestructive(title: "탈퇴하기",
                                            message: "탈퇴시 저장된 기록은 복구되지 않습니다.\n 정말로 탈퇴하시겠습니까?",
                                            okActionTitle: "탈퇴",
                                            okAction:  { _ in
            self.WithdrawalActionTapped.accept(())
        })
    }
}
