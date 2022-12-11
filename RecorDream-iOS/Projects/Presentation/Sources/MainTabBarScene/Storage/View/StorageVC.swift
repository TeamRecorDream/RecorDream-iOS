//
//  StorageVC.swift
//  Presentation
//
//  Created by 정은희 on 2022/12/08.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_Core
import RD_DSKit

import SnapKit

final class StorageVC: UIViewController {
    // MARK: - Properties
    lazy var dataSource: UICollectionViewDiffableDataSource<DreamStorageSection, AnyHashable>! = nil
    
    // MARK: - UI Components
    private lazy var logoView = DreamLogoView()
    private lazy var dreamStorageCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = RDDSKitAsset.Colors.dark.color
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cv.allowsMultipleSelection = true
        return cv
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.setupConstraint()
        self.assignDelegate()
        self.registerView()
    }
}

extension StorageVC {
    private func setupView() {
        self.view.addSubviews(logoView, dreamStorageCollectionView)
    }
    private func setupConstraint() {
        self.logoView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(18)
            make.height.equalTo(24.adjustedHeight)
        }
        self.dreamStorageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(logoView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension StorageVC {
    private func assignDelegate() {
        dreamStorageCollectionView.delegate = self
    }
    private func registerView() {
        self.dreamStorageCollectionView.register(StorageHeaderCVC.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StorageHeaderCVC.reuseIdentifier)
        self.dreamStorageCollectionView.register(StorageExistCVC.self, forCellWithReuseIdentifier: StorageExistCVC.reuseIdentifier)
        self.dreamStorageCollectionView.register(StorageEmptyCVC.self, forCellWithReuseIdentifier: StorageEmptyCVC.reuseIdentifier)
    }
}

extension StorageVC {
    private func setDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource<DreamStorageSection, AnyHashable>(collectionView: dreamStorageCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch DreamStorageSection.type(indexPath.section) {
            case .filters:
                guard let filterCell = collectionView.dequeueReusableCell(withReuseIdentifier: DreamWriteEmotionCVC.reuseIdentifier, for: indexPath) as? DreamWriteEmotionCVC else { return UICollectionViewCell() }
                filterCell.setData(selectedImage: DreamStorageSection.icons[indexPath.row], deselectedImage: DreamStorageSection.deselectedIcons[indexPath.row], text: DreamStorageSection.titles[indexPath.row])
//                if let model = itemIdentifier as? TODO: -
                return filterCell
            case .records:
                // 만약 엔티티 개수 = 0이면 지우도록.
                guard let emptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: StorageEmptyCVC.reuseIdentifier, for: indexPath) as? StorageEmptyCVC else { return UICollectionViewCell() }
                guard let existCell = collectionView.dequeueReusableCell(withReuseIdentifier: StorageExistCVC.reuseIdentifier, for: indexPath) as? StorageExistCVC else { return UICollectionViewCell() }
//                existCell.setData(emotion: <#T##Int#>, date: <#T##String#>, title: <#T##String#>, tag: <#T##[String]#>)
                // TODO: - 선택하면 상세보기로 화면전환
                return existCell
            }
        })
        
        self.dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            switch kind {
            case DreamWriteHeader.className:
                guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DreamWriteHeader.className, for: indexPath) as? DreamWriteHeader else { return UICollectionReusableView() }
                let sectionType = DreamStorageSection.type(indexPath.section)
                view.title = sectionType.title
                return view
            case StorageHeaderCVC.className:
                guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: StorageHeaderCVC.reuseIdentifier, for: indexPath) as? DreamWriteHeader else { return UICollectionReusableView() }
                // TODO: - n개의 기록 추가
//                view.title
                return view
            default: return UICollectionReusableView()
            }
        }
    }
}

extension StorageVC: UICollectionViewDelegate {
    
}
