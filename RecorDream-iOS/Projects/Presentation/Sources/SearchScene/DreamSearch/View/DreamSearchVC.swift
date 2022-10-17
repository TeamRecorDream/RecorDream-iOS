//
//  DreamSearchVC.swift
//  Presentation
//
//  Created by 정은희 on 2022/10/10.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_DSKit

@available(iOS 16.0, *)
public class DreamSearchVC: UIViewController {
    // MARK: - UI Components
    private lazy var navigationBar = RDNaviBar().title("검색하기")
    private lazy var searchLabel: UILabel = {
        let lb = UILabel()
        lb.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 14.adjusted)
        lb.text = "검색어 입력"
        lb.textColor = .white
        return lb
    }()
    private lazy var searchButton: UIButton = {
        let bt = UIButton()
        bt.setImage(RDDSKitAsset.Images.icnSearch.image, for: .normal)
        bt.contentMode = .scaleAspectFit
        return bt
    }()
    private lazy var searchTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .gray
        tf.backgroundColor = .white.withAlphaComponent(0.05)
        tf.clipsToBounds = true
        tf.font = RDDSKitFontFamily.Pretendard.medium.font(size: 14.adjusted)
        tf.makeRoundedWithBorder(radius: 15, borderColor: UIColor.white.withAlphaComponent(0.1).cgColor)
        tf.placeholder = "어떤 기록을 찾고 있나요?"
        tf.setPlaceholderColor(UIColor.white.withAlphaComponent(0.4))
        tf.setLeftPadding(amount: 52)
        return tf
    }()
    private lazy var dreamSearchCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: self.layout())
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = RDDSKitAsset.Colors.dark.color
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cv.allowsMultipleSelection = true
        return cv
    }()
    
    // MARK: - View Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.setupConstraint()
//        self.assignDelegate()
        self.registerXib()
    }
}

@available(iOS 16.0, *)
extension DreamSearchVC: DreamSearhControllable {
    public func setupView() {
        self.view.backgroundColor = .black
        self.view.addSubviews(navigationBar, searchLabel, searchButton, searchTextField, dreamSearchCollectionView)
    }
    
    public func setupConstraint() {
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44.adjustedHeight)
        }
        searchLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(34)
            make.leading.equalToSuperview().offset(16)
        }
        searchTextField.snp.makeConstraints { make in
            make.height.equalTo(46.adjustedHeight)
            make.centerX.equalToSuperview().inset(16)
            make.top.equalTo(searchLabel.snp.bottom).offset(16)
        }
        searchButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.equalTo(searchTextField)
            make.leading.equalToSuperview().offset(36)
        }
        dreamSearchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
//    private func assignDelegate() {
//        dreamSearchCollectionView.dataSource = self
//        dreamSearchCollectionView.delegate = self
//    }
    private func registerXib() {
        dreamSearchCollectionView.register(DreamSearchBottomCVC.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: DreamSearchBottomCVC.reuseIdentifier)
        dreamSearchCollectionView.register(DreamSearchCountCVC.self, forCellWithReuseIdentifier: DreamSearchCountCVC.reuseIdentifier)
        dreamSearchCollectionView.register(DreamSearchEmptyCVC.self, forCellWithReuseIdentifier: DreamSearchEmptyCVC.reuseIdentifier)
        dreamSearchCollectionView.register(DreamSearchExistCVC.self, forCellWithReuseIdentifier: DreamSearchExistCVC.reuseIdentifier)
        
    }
}

//@available(iOS 16.0, *)
//extension DreamSearchVC: UICollectionViewDataSource, UICollectionViewDelegate {
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        switch
//    }
//    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        <#code#>
//    }
//    public func numberOfSections(in collectionView: UICollectionView) -> Int {
//        <#code#>
//    }
//    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
//}
