//
//  DreamDetailMoreVC.swift
//  PresentationTests
//
//  Created by 김수연 on 2022/12/30.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import UIKit

import RD_DSKit

import RxSwift
import SnapKit

public class DreamDetailMoreVC: UIViewController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    public var viewModel: DreamDetailMoreViewModel!
    public var factory: ViewControllerFactory!
  
    // MARK: - UI Components

    private let bottomView: UIView = {
        let view = UIView()
        view.makeRounded(radius: 15)
        view.backgroundColor = RDDSKitAsset.Colors.grey01.color
        return view
    }()

    private let separateLine: UIView = {
        let view = UIView()
        view.backgroundColor = RDDSKitAsset.Colors.white01.color.withAlphaComponent(0.1)
        return view
    }()

    private let secondSeparateLine: UIView = {
        let view = UIView()
        view.backgroundColor = RDDSKitAsset.Colors.white01.color.withAlphaComponent(0.1)
        return view
    }()

    private lazy var shareButton: UIButton = {
        var container = AttributeContainer()
        container.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 14)

        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("공유하기", attributes: container)

        configuration.baseForegroundColor = RDDSKitAsset.Colors.white01.color

        let button = UIButton(configuration: configuration, primaryAction: nil)
        return button
    }()

    private lazy var editButton: UIButton = {
        var container = AttributeContainer()
        container.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 14)

        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("수정하기", attributes: container)
        configuration.baseForegroundColor = RDDSKitAsset.Colors.white01.color
        let button = UIButton(configuration: configuration, primaryAction: nil)
        return button
    }()

    private lazy var deleteButton: UIButton = {
        var container = AttributeContainer()
        container.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 14)

        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("삭제하기", attributes: container)

        configuration.baseForegroundColor = RDDSKitAsset.Colors.white01.color
        let button = UIButton(configuration: configuration, primaryAction: nil)
        return button
    }()

    private lazy var bottomCancleButton: UIButton = {
        var container = AttributeContainer()
        container.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 14)

        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("취소", attributes: container)

        configuration.baseForegroundColor = RDDSKitAsset.Colors.white01.color
        configuration.background.backgroundColor = RDDSKitAsset.Colors.grey02.color

        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.makeRounded(radius: 15)
        return button
    }()
  
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        self.bind()
        self.bindViewModels()
        self.setUI()
        self.setLayout()
    }

    // MARK: - UI & Layout
    private func setUI() {
        self.view.backgroundColor = RDDSKitAsset.Colors.dark.color.withAlphaComponent(0.65)
    }

    private func setLayout() {
        self.view.addSubviews(bottomView, bottomCancleButton)

        bottomCancleButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(14)
            $0.height.equalTo(50)
        }

        bottomView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(bottomCancleButton.snp.top).offset(-8)
            $0.height.equalTo(150.adjustedH)
        }

        bottomView.addSubviews(separateLine, secondSeparateLine, shareButton, editButton, deleteButton)


        shareButton.snp.makeConstraints {
            $0.height.equalTo(49.adjustedH)
            $0.top.leading.trailing.equalToSuperview()
        }

        separateLine.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
            $0.top.equalTo(shareButton.snp.bottom)
        }

        editButton.snp.makeConstraints {
            $0.height.equalTo(49.adjustedH)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(separateLine.snp.bottom)
        }

        secondSeparateLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(editButton.snp.bottom)
        }

        deleteButton.snp.makeConstraints {
            $0.height.equalTo(49.adjustedH)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(secondSeparateLine.snp.bottom)
        }
    }
}

// MARK: - Methods

extension DreamDetailMoreVC {

    private func bind() {
        self.bottomCancleButton.rx.tap
            .asDriver()
            .drive(onNext: {
                self.dismiss(animated: false)
            })
            .disposed(by: self.disposeBag)

        self.deleteButton.rx.tap
            .asDriver()
            .drive(onNext: {
                self.makeAlertWithCancelDestructive(title: "삭제하기",
                                                    message: "꿈 기록을 삭제하시겠습니까?",
                                                    okActionTitle: "삭제",
                                                    okAction:  { _ in
                    // 삭제 로직 실행 todo
                })
            }).disposed(by: self.disposeBag)
    }
  
    private func bindViewModels() {
        let input = DreamDetailMoreViewModel.Input()
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    }

}
