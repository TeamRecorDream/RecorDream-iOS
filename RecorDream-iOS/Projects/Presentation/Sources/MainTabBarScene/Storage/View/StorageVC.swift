//
//  StorageVC.swift
//  Presentation
//
//  Created by 정은희 on 2022/12/08.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import Domain
import RD_DSKit

import RxSwift
import RxCocoa

public class StorageVC: UIViewController {
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
    
    // MARK: - Reactive Stuff
    private let filterButtonTapped = PublishRelay<Int>()
    private let fetchedCount = BehaviorRelay<Int>(value: 0)
    private var disposeBag = DisposeBag()
    public var factory: ViewControllerFactory!
    public var viewModel: DreamStorageViewModel!
    var dataSource: UICollectionViewDiffableDataSource<DreamStorageSection, AnyHashable>! = nil
    
    // MARK: - Properties
    private var filterList: [DreamStorageEntity.FilterList] = []
    
    // MARK: - View Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.setupConstraint()
        self.registerView()
        self.setDelegate()
        self.setDataSource()
        self.bindViewModels()
    }
}

// MARK: - UI
extension StorageVC {
    private func setupView() {
        self.view.backgroundColor = RDDSKitAsset.Colors.dark.color
        self.view.addSubviews(logoView, dreamStorageCollectionView)
    }
    private func setupConstraint() {
        self.logoView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(18)
            make.height.equalTo(23.adjustedHeight)
        }
        self.dreamStorageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(logoView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    private func setDelegate() {
        self.dreamStorageCollectionView.delegate = self
    }
    private func registerView() {
        DreamWriteHeader.register(target: self.dreamStorageCollectionView)
        DreamWriteEmotionCVC.register(target: self.dreamStorageCollectionView)
        StorageHeaderCVC.register(target: self.dreamStorageCollectionView)
        StorageExistCVC.register(target: self.dreamStorageCollectionView)
    }
}

// MARK: - DataSource
extension StorageVC {
    private func setDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource<DreamStorageSection, AnyHashable>(collectionView: dreamStorageCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            if let model = itemIdentifier as? DreamStorageEntity.RecordList {
                if model.records.isEmpty {
                    self.dreamStorageCollectionView.setEmptyView(message: "아직 기록된 꿈이 없어요.", image: UIImage())
                }
                else {
                    self.dreamStorageCollectionView.restore()
                    guard let existCell = collectionView.dequeueReusableCell(withReuseIdentifier: StorageExistCVC.reuseIdentifier, for: indexPath) as? StorageExistCVC else { return UICollectionViewCell() }
                    
                    let currentRecord = model.records[indexPath.row]
                    existCell.setData(emotion: currentRecord.emotion ?? 0, date: currentRecord.date ?? "", title: currentRecord.title ?? "", tag: currentRecord.genre ?? [])
                    return existCell
                }
            }
            else {
                guard let filterCell = collectionView.dequeueReusableCell(withReuseIdentifier: DreamWriteEmotionCVC.reuseIdentifier, for: indexPath) as? DreamWriteEmotionCVC else { return UICollectionViewCell() }
                if let model = itemIdentifier as? DreamStorageEntity.FilterList {
                    if model.isSelected {
                        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .right)
                        collectionView.scrollToItem(at: IndexPath.init(item: 0, section: 0), at: .left, animated: false)
                        self.filterSnapShot()
                    }
                }
                return filterCell
            }
            return UICollectionViewCell()
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
                view.title = "\(self.fetchedCount.value)개의 기록"
                return view
            default: return UICollectionReusableView()
            }
        }
    }
    private func filterSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<DreamStorageSection, AnyHashable>()
        snapshot.appendSections([.filters])
        snapshot.appendItems(self.filterList, toSection: .filters)
        self.dataSource.apply(snapshot)
    }
    private func applySnapshot(model: DreamStorageEntity.RecordList?) {
        guard let model = model else { return }
        print("얍", model)
        var snapshot = NSDiffableDataSourceSnapshot<DreamStorageSection, AnyHashable>()
        print("얍 개수?", model.recordsCount)
        self.fetchedCount.accept(model.recordsCount)
        snapshot.appendSections([.records])
        
        snapshot.appendItems(model.records, toSection: .records)
        self.dataSource.apply(snapshot)
        self.view.setNeedsLayout()
    }
}

// MARK: - Bind
extension StorageVC {
    private func bindViewModels() {
        let input = DreamStorageViewModel.Input(viewDidLoad: Observable.just(()),
                                                filterButtonTapped: self.filterButtonTapped.asObservable())
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
        
        output.storageDataFetched
            .withUnretained(self)
            .subscribe(onNext: { owner, entity in
                owner.applySnapshot(model: entity)
            }).disposed(by: self.disposeBag)
        
        output.loadingStatus
            .bind(to: self.rx.isLoading)
            .disposed(by: disposeBag)
    }
    
}

extension StorageVC: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        switch DreamStorageSection.type(indexPath.section) {
        case .filters:
            var selectedIndexPath: IndexPath? = nil
            selectedIndexPath = collectionView.indexPathsForSelectedItems?
                .first { $0.section == indexPath.section }
            self.filterButtonTapped.accept(indexPath.item + 1)
            guard let selected = selectedIndexPath else { return true }
            collectionView.deselectItem(at: selected, animated: false)
            return true
        case .records:
            let detailVC = self.factory.instantiateDetailVC(dreamId: "")
            detailVC.modalTransitionStyle = .coverVertical
            detailVC.modalPresentationStyle = .fullScreen
            guard let rdtabbarController = self.tabBarController as? RDTabBarController else { return false }
            rdtabbarController.rdTabBar.isHidden = true
            self.present(detailVC, animated: true)
            return true
        }
    }
    public func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        switch DreamStorageSection.type(indexPath.section) {
        case .filters:
            return true
        default:
            return false
        }
    }
}
