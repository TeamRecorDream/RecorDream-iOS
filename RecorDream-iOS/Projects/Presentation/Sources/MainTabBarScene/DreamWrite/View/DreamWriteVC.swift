//
//  DreamWriteVC.swift
//  RD-Navigator
//
//  Created by Junho Lee on 2022/09/29.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_Core
import RD_DSKit

import RxSwift

public class DreamWriteVC: UIViewController {
    
    // MARK: - Properties
    
    enum Section {
        case main
        case emotions
        case genres
        case note
    }
    
    private let disposeBag = DisposeBag()
    
    public var viewModel: DreamWriteViewModel!
    
    let sections: [Section] = [
        .main,
        .emotions,
        .genres,
        .note
    ]
    
    // MARK: - UI Components
    
    private lazy var naviBar = RDNaviBar()
        .title("기록하기")
    
    private lazy var dreamWriteCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = RDDSKitAsset.Colors.dark.color
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return cv
    }()
    
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setCollectionView()
        self.setDelegate()
        self.setGesture()
        self.setLayout()
        self.bindViewModels()
    }
}

// MARK: - Methods

extension DreamWriteVC {
    
    private func setUI() {
        self.view.backgroundColor = RDDSKitAsset.Colors.dark.color
    }
    
    private func setDelegate() {
        dreamWriteCollectionView.delegate = self
        dreamWriteCollectionView.dataSource = self
    }
    
    private func setLayout() {
        self.view.addSubviews(dreamWriteCollectionView, naviBar)
        
        dreamWriteCollectionView.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        naviBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
    }
    
    private func setCollectionView() {
        DreamWriteMainCVC.register(target: dreamWriteCollectionView)
        DreamWriteEmotionCVC.register(target: dreamWriteCollectionView)
        DreamWriteGenreCVC.register(target: dreamWriteCollectionView)
        DreamWriteHeader.register(target: dreamWriteCollectionView)
    }
    
    private func bindViewModels() {
        let input = DreamWriteViewModel.Input(viewDidDisappearEvent: self.rx.viewDidDisappear,
                                              closeButtonTapped: naviBar.rightButtonTapped.asObservable())
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    }
    
    private func setGesture() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:))))
    }

    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            view.endEditing(true)
        }
        sender.cancelsTouchesInView = false
    }
}

extension DreamWriteVC: UICollectionViewDelegate {
    
}

extension DreamWriteVC: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = sections[section]
        switch sectionType {
        case .main: return 1
        case .emotions: return 5
        case .genres: return 10
        case .note: return 1
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .main:
            guard let mainCell = collectionView.dequeueReusableCell(withReuseIdentifier: DreamWriteMainCVC.className, for: indexPath) as? DreamWriteMainCVC else { return UICollectionViewCell() }
            let colors: [UIColor] = [RDDSKitAsset.Colors.dark.color, .systemPink, .orange, .brown, .yellow, .purple, .red, .green]
            mainCell.backgroundColor = colors[indexPath.row]
            return mainCell
        case .emotions:
            guard let mainCell = collectionView.dequeueReusableCell(withReuseIdentifier: DreamWriteEmotionCVC.className, for: indexPath) as? DreamWriteEmotionCVC else { return UICollectionViewCell() }
            let images = [RDDSKitAsset.Images.feelingSad.image, RDDSKitAsset.Images.feelingBright.image, RDDSKitAsset.Images.feelingFright.image, RDDSKitAsset.Images.feelingWeird.image, RDDSKitAsset.Images.feelingShy.image]
            let titles = ["기쁜", "슬픈", "무서운", "이상한", "민망한"]
            mainCell.setData(image: images[indexPath.row], text: titles[indexPath.row])
            return mainCell
        case .genres:
            guard let mainCell = collectionView.dequeueReusableCell(withReuseIdentifier: DreamWriteGenreCVC.className, for: indexPath) as? DreamWriteGenreCVC else { return UICollectionViewCell() }
            let colors: [UIColor] = [.blue, .systemPink, .orange, .brown, .yellow, .purple, .red, .green, .darkGray, .systemCyan]
            let strings = ["코미디", "로맨스", "판타지", "가족", "친구", "공포", "동물", "음식", "일", "기타"].map { "# " + $0 }
            mainCell.backgroundColor = colors[indexPath.row]
            mainCell.setData(text: strings[indexPath.row])
            self.dreamWriteCollectionView.setNeedsLayout()
            return mainCell
        case .note:
            guard let mainCell = collectionView.dequeueReusableCell(withReuseIdentifier: DreamWriteMainCVC.className, for: indexPath) as? DreamWriteMainCVC else { return UICollectionViewCell() }
            let colors: [UIColor] = [RDDSKitAsset.Colors.dark.color, .black, .orange, .brown, .yellow, .purple, .red, .green]
            mainCell.backgroundColor = colors[indexPath.row]
            return mainCell
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == DreamWriteHeader.className {
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DreamWriteHeader.className, for: indexPath) as? DreamWriteHeader else { return UICollectionReusableView() }
            let section = sections[indexPath.section]
            switch section {
            case .main:
                view.title = "나의 감정"
            case .emotions:
                view.title = "나의 감정"
            case .genres:
                view.title = "꿈의 장르"
            case .note:
                view.title = "노트"
            }
            return view
        } else { return UICollectionReusableView() }
    }
}
