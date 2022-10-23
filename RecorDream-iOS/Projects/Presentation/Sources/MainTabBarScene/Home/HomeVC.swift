//
//  HomeVC.swift
//  
//
//  Created by 김수연 on 2022/10/23.
//

import UIKit

import RD_DSKit

import RxSwift
import SnapKit

public class HomeVC: UIViewController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    public var viewModel: HomeViewModel!
  
    // MARK: - UI Components

    private let logoView = DreamLogoView()
    private let backgroundView = UIImageView(image: RDDSKitAsset.Images.homeBackground.image)

    private var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "반가워요, 드림님!"
        label.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 24.adjusted)
        label.textColor = RDDSKitColors.Color.white
        return label
    }()

    private let desciptionLabel: UILabel = {
        let label = UILabel()
        label.text = "그동안 어떤 꿈을 꾸셨나요?"
        label.font = RDDSKitFontFamily.Pretendard.extraLight.font(size: 24.adjusted)
        label.textColor = RDDSKitColors.Color.white
        return label
    }()
  
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModels()
        self.setUI()
        self.setLayout()
    }

    // MARK: - UI & Layout
    private func setUI() {
        self.view.backgroundColor = RDDSKitAsset.Colors.dark.color
    }

    private func setLayout() {
        self.view.addSubviews(backgroundView, logoView, welcomeLabel, desciptionLabel)

        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        logoView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(18)
            $0.height.equalTo(24.adjustedH)
        }

        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(logoView.snp.bottom).offset(44)
            $0.leading.equalToSuperview().inset(22)
        }

        desciptionLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(8)
            $0.leading.equalTo(welcomeLabel.snp.leading)
        }

    }
}

// MARK: - Methods

extension HomeVC {
  
    private func bindViewModels() {
        let input = HomeViewModel.Input()
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    }

}
