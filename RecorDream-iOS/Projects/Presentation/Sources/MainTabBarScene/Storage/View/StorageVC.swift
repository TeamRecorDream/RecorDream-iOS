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
    private var storageHeader: StorageHeaderCVC?
    private let fetchedCount = PublishRelay<Int>()
    
    // MARK: - Reactive Stuff
    private let emotionTapped = BehaviorRelay<Int>(value: 0)
    private var selectedIndex = PublishRelay<Int>()
    private let dreamId = PublishRelay<String>()
    private var disposeBag = DisposeBag()
    public var factory: ViewControllerFactory!
    public var viewModel: DreamStorageViewModel!
    var dataSource: UICollectionViewDiffableDataSource<DreamStorageSection, AnyHashable>! = nil
    
    // MARK: - Properties
    public var currentLayoutType = RDCollectionViewFlowLayout.CollectionDisplay.grid
    
    // MARK: - View Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraint()
        self.registerView()
        self.setDelegate()
        self.setDataSource()
        self.bindViews()
        self.bindViewModels()
        self.bindCollectionView()
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setDataSource()
        self.bindViews()
        self.bindViewModels()
        self.dreamStorageCollectionView.reloadData()
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
            make.top.equalTo(logoView.snp.bottom).offset(20)
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
            switch indexPath.section {
            case 0:
                guard let filterCell = collectionView.dequeueReusableCell(withReuseIdentifier: DreamWriteEmotionCVC.reuseIdentifier, for: indexPath) as? DreamWriteEmotionCVC else { return UICollectionViewCell() }
                filterCell.setData(selectedImage: DreamStorageSection.icons[indexPath.row],
                                   deselectedImage: DreamStorageSection.deselectedIcons[indexPath.row],
                                   text: DreamStorageSection.titles[indexPath.row])
                let isSelected = indexPath.row == self.emotionTapped.value
                if indexPath.item == 0 {
                    filterCell.isSelected = true
                    collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
                }
                filterCell.isSelected = isSelected
                return filterCell
            case 1:
                if let model = itemIdentifier as? DreamStorageEntity.RecordList.Record {
                    guard let existCell = collectionView.dequeueReusableCell(withReuseIdentifier: StorageExistCVC.reuseIdentifier, for: indexPath) as? StorageExistCVC else { return UICollectionViewCell() }
                    let currentRecord = model
                    existCell.setupConstraint(layoutType: self.currentLayoutType)
                    existCell.setData(emotion: currentRecord.emotion ?? 0,
                                      date: currentRecord.date ?? "",
                                      title: currentRecord.title ?? "",
                                      tag: currentRecord.genre ?? [],
                                      layoutType: self.currentLayoutType)
                    return existCell
                } else { return UICollectionViewCell() }
            default: return UICollectionViewCell()
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
                self.storageHeader = nil
                guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: StorageHeaderCVC.className, for: indexPath) as? StorageHeaderCVC else { return UICollectionReusableView() }
                self.storageHeader = view
                view.currentType = self.currentLayoutType
                view.title = "\(self.dataSource.snapshot(for: .records).items.count)개의 기록"
                view.layoutTypeChanged
                    .skip(1)
                    .drive(onNext: { [weak self] in
                        guard let self = self else { return }
                        self.changeLayoutType(type: $0)
                    }).disposed(by: view.disposeBag)
                return view
            default: return UICollectionReusableView()
            }
        }
    }
    
    private func applySnapshot(model: DreamStorageEntity.RecordList?) {
        guard let model = model else { return }
        var snapshot = NSDiffableDataSourceSnapshot<DreamStorageSection, AnyHashable>()
        self.fetchedCount.accept(model.recordsCount)
        snapshot.appendSections([.filters, .records])
        snapshot.appendItems([0, 1, 2, 3, 4, 5, 6], toSection: .filters)
        if model.recordsCount == 0 {
            self.dreamStorageCollectionView.setEmptyView(message: "아직 기록된 꿈이 없어요.", image: UIImage())
        } else {
            self.dreamStorageCollectionView.restore()
            snapshot.appendItems(model.records, toSection: .records)
        }
        self.dataSource.apply(snapshot)
        self.view.setNeedsLayout()
    }
    
    private func changeLayoutType(type: RDCollectionViewFlowLayout.CollectionDisplay) {
        self.currentLayoutType = type
        self.reapplySnapShot()
        self.view.setNeedsLayout()
    }
    
    private func reapplySnapShot() {
        var snapshot = self.dataSource.snapshot()
        guard let items = snapshot.itemIdentifiers(inSection: .records) as? [DreamStorageEntity.RecordList.Record] else { return }
        let newItems: [DreamStorageEntity.RecordList.Record] = items.map { item in
            var changedItem = item
            changedItem.toggleLayoutHandler()
            return changedItem
        }
        snapshot.deleteSections([.records])
        snapshot.appendSections([.records])
        snapshot.appendItems(newItems, toSection: .records)
        self.dataSource.apply(snapshot)
    }
}

// MARK: - Bind
extension StorageVC {
    private func bindViewModels() {
        let input = DreamStorageViewModel.Input(viewDidLoad: Observable.just(()),
                                                filterButtonTapped: self.emotionTapped.skip(1).asObservable())
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
    
    private func bindViews() {
        self.fetchedCount
            .asDriver(onErrorJustReturn: 0)
            .drive { [weak self] count in
                guard let self = self,
                    let header = self.storageHeader else { return }
                header.title = "\(count)개의 기록"
            }.disposed(by: self.disposeBag)

        self.logoView.rx.searchButtonTapped
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                let searchVC = owner.factory.instantiateSearchVC()
                let navigation = UINavigationController(rootViewController: searchVC)
                navigation.modalTransitionStyle = .coverVertical
                navigation.modalPresentationStyle = .fullScreen
                guard let rdtabbarController = owner.tabBarController as? RDTabBarController else { return }
                owner.present(navigation, animated: true)
            }).disposed(by: self.disposeBag)
        
        self.logoView.rx.mypageButtonTapped
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                let mypageVC = owner.factory.instantiateMyPageVC()
                owner.navigationController?.pushViewController(mypageVC, animated: true)
                guard let rdtabbarController = owner.tabBarController as? RDTabBarController else { return }
                rdtabbarController.setTabBarHidden()
            }).disposed(by: self.disposeBag)
    }
    private func bindCollectionView() {
        self.selectedIndex
            .bind(onNext: { idx in
                guard let id = self.viewModel.fetchedDreamRecord.records.safeget(index: idx)?.id else { return }
                self.dreamId.accept(id)
            }).disposed(by: self.disposeBag)
        
        self.dreamId
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: { id in
                let detailVC = self.factory.instantiateDetailVC(dreamId: id)
                detailVC.modalTransitionStyle = .coverVertical
                detailVC.modalPresentationStyle = .pageSheet
                guard let rdtabbarController = self.tabBarController as? RDTabBarController else { return }
                rdtabbarController.setTabBarHidden()
                self.present(detailVC, animated: true)
            }).disposed(by: self.disposeBag)
    }
}

extension StorageVC: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        switch DreamStorageSection.type(indexPath.section) {
        case .filters:
            var selectedIndexPath: IndexPath? = nil
            selectedIndexPath = collectionView.indexPathsForSelectedItems?
                .first { $0.section == indexPath.section }
            self.emotionTapped.accept(indexPath.item)
            guard let selected = selectedIndexPath else { return true }
            collectionView.deselectItem(at: selected, animated: false)
            return true
        case .records:
            self.selectedIndex.accept(indexPath.row)
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
