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
    
    enum SupplementaryViewKind {
        static let header = "header"
        static let bottomLine = "bottomLine"
        static let bottomLabel = "bottomLabel"
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
    
    private lazy var dreamWriteCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = RDDSKitColors.Color.white
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return cv
    }()
    
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setCollectionView()
        self.setDelegate()
        self.setLayout()
        self.bindViewModels()
    }
}

// MARK: - Methods

extension DreamWriteVC {
    
    private func setUI() {
        self.view.backgroundColor = .brown
    }
    
    private func setDelegate() {
        dreamWriteCollectionView.delegate = self
        dreamWriteCollectionView.dataSource = self
    }
    
    private func setLayout() {
        self.view.addSubviews(dreamWriteCollectionView)
        
        dreamWriteCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setCollectionView() {
        DreamWriteMainCVC.register(target: dreamWriteCollectionView)
        DreamWriteGenreCVC.register(target: dreamWriteCollectionView)
    }
    
    private func bindViewModels() {
        let input = DreamWriteViewModel.Input(viewDidDisappearEvent: self.rx.methodInvoked(#selector(UIViewController.viewDidDisappear(_:))).map { _ in })
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
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
            let colors: [UIColor] = [.blue, .black, .orange, .brown, .yellow, .purple, .red, .green]
            mainCell.backgroundColor = colors[indexPath.row]
            return mainCell
        case .emotions:
            guard let mainCell = collectionView.dequeueReusableCell(withReuseIdentifier: DreamWriteMainCVC.className, for: indexPath) as? DreamWriteMainCVC else { return UICollectionViewCell() }
            let colors: [UIColor] = [.blue, .black, .orange, .brown, .yellow, .purple, .red, .green]
            mainCell.backgroundColor = colors[indexPath.row]
            return mainCell
        case .genres:
            guard let mainCell = collectionView.dequeueReusableCell(withReuseIdentifier: DreamWriteGenreCVC.className, for: indexPath) as? DreamWriteGenreCVC else { return UICollectionViewCell() }
            let colors: [UIColor] = [.blue, .black, .orange, .brown, .yellow, .purple, .red, .green, .darkGray, .systemCyan]
            let strings = ["코미디", "로맨스", "판타지", "가족", "친구", "공포", "동물", "음식", "일", "기타"].map { "# " + $0 }
            mainCell.backgroundColor = colors[indexPath.row]
            mainCell.setData(text: strings[indexPath.row])
            self.dreamWriteCollectionView.setNeedsLayout()
            return mainCell
        case .note:
            guard let mainCell = collectionView.dequeueReusableCell(withReuseIdentifier: DreamWriteMainCVC.className, for: indexPath) as? DreamWriteMainCVC else { return UICollectionViewCell() }
            let colors: [UIColor] = [.blue, .black, .orange, .brown, .yellow, .purple, .red, .green]
            mainCell.backgroundColor = colors[indexPath.row]
            return mainCell
        }
    }
}
