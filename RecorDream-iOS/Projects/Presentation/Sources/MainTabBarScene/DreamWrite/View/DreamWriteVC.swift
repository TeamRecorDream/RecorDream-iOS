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
    
    private let disposeBag = DisposeBag()
    
    public var viewModel: DreamWriteViewModel!
    
    // TODO: - dataType 프로토콜로 구현하고 수정하기
    
    lazy var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    
    // MARK: - UI Components
    
    private lazy var naviBar = RDNaviBar()
        .title("기록하기")
    
    private lazy var dreamWriteCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = RDDSKitAsset.Colors.dark.color
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cv.allowsMultipleSelection = true
        return cv
    }()
    
    private lazy var saveButton = DreamWriteSaveButton()
        .title("저장하기")
    
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setLayout()
        self.setDelegate()
        self.registerReusables()
        self.setGesture()
        self.bindViewModels()
        self.setDataSource()
        self.applySnapshot()
    }
}

// MARK: - UI & Layout

extension DreamWriteVC {
    
    private func setUI() {
        self.view.backgroundColor = RDDSKitAsset.Colors.dark.color
    }
    
    private func setLayout() {
        self.view.addSubviews(dreamWriteCollectionView, naviBar, saveButton)
        
        dreamWriteCollectionView.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        naviBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        saveButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(88)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Methods

extension DreamWriteVC {
    
    private func setDelegate() {
        dreamWriteCollectionView.delegate = self
    }
    
    private func registerReusables() {
        DreamWriteMainCVC.register(target: dreamWriteCollectionView)
        DreamWriteEmotionCVC.register(target: dreamWriteCollectionView)
        DreamWriteGenreCVC.register(target: dreamWriteCollectionView)
        DreamWriteNoteCVC.register(target: dreamWriteCollectionView)
        DreamWriteHeader.register(target: dreamWriteCollectionView)
        DreamWriteWarningFooter.register(target: dreamWriteCollectionView)
        DreamWriteDividerView.register(target: dreamWriteCollectionView)
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

// MARK: - Bind

extension DreamWriteVC {
    
    private func bindViewModels() {
        let input = DreamWriteViewModel.Input(viewDidDisappearEvent: self.rx.viewDidDisappear,
                                              closeButtonTapped: naviBar.rightButtonTapped.asObservable())
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    }
    
}


// MARK: - DiffableDataSource

extension DreamWriteVC {
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: dreamWriteCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch Section.type(indexPath.section) {
            case .main:
                guard let mainCell = collectionView.dequeueReusableCell(withReuseIdentifier: DreamWriteMainCVC.className, for: indexPath) as? DreamWriteMainCVC else { return UICollectionViewCell() }
                mainCell.endEditing.subscribe(onNext: {
                    self.view.endEditing(true)
                }).disposed(by: self.disposeBag)
                return mainCell
            case .emotions:
                guard let emotionsCell = collectionView.dequeueReusableCell(withReuseIdentifier: DreamWriteEmotionCVC.className, for: indexPath) as? DreamWriteEmotionCVC else { return UICollectionViewCell() }
                emotionsCell.setData(selectedImage: Section.emotionImages[indexPath.row],
                                 deselectedImage: Section.emotionDeselectedImages[indexPath.row],
                                 text: Section.emotionTitles[indexPath.row])
                return emotionsCell
            case .genres:
                guard let genresCell = collectionView.dequeueReusableCell(withReuseIdentifier: DreamWriteGenreCVC.className, for: indexPath) as? DreamWriteGenreCVC else { return UICollectionViewCell() }
                genresCell.setData(text: Section.genreTitles[indexPath.row])
                return genresCell
            case .note:
                guard let noteCell = collectionView.dequeueReusableCell(withReuseIdentifier: DreamWriteNoteCVC.className, for: indexPath) as? DreamWriteNoteCVC else { return UICollectionViewCell() }
                return noteCell
            }
        })
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            switch kind {
            case DreamWriteHeader.className:
                guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DreamWriteHeader.className, for: indexPath) as? DreamWriteHeader else { return UICollectionReusableView() }
                let sectionType = Section.type(indexPath.section)
                view.title = sectionType.title
                return view
            case DreamWriteWarningFooter.className:
                guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DreamWriteWarningFooter.className, for: indexPath) as? DreamWriteWarningFooter else { return UICollectionReusableView() }
                return view
            case DreamWriteDividerView.className:
                guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DreamWriteDividerView.className, for: indexPath) as? DreamWriteDividerView else { return UICollectionReusableView() }
                return view
            default: return UICollectionReusableView()
            }
        }
    }
    
    // TODO: - 기록하기용 SnapShot과 수정하기용 SnapShot 구분하기
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main, .emotions, .genres, .note])
        snapshot.appendItems([1],toSection: .main)
        snapshot.appendItems([3,4,5,6,7],toSection: .emotions)
        snapshot.appendItems([8,9,10,11,12,13,14,15,16,17],toSection: .genres)
        snapshot.appendItems([18],toSection: .note)
        dataSource.apply(snapshot, animatingDifferences: false)
        self.view.setNeedsLayout()
    }
}

// MARK: - UICollectionViewDelegate

extension DreamWriteVC: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        switch Section.type(indexPath.section) {
        case .emotions:
            var selectedIndexPath: IndexPath? = nil
            collectionView.indexPathsForSelectedItems?.forEach {
                if $0.section == indexPath.section {
                    selectedIndexPath = $0
                }
            }
            guard let selected = selectedIndexPath else { return true }
            collectionView.deselectItem(at: selected, animated: false)
            return true
        case .genres:
            var selectedCount = 0
            collectionView.indexPathsForSelectedItems?.forEach {
                if $0.section == indexPath.section {
                    selectedCount += 1
                }
            }
            if selectedCount == 3 {
                collectionView.deselectItem(at: indexPath, animated: false)
                return false
            } else { return true }
        default:
            return false
        }
    }
}