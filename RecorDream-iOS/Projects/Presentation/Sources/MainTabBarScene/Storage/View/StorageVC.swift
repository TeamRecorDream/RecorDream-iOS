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
    private lazy var dreamFilterCollectionView: UICollectionView = {
        let layout = self.createFilterLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = RDDSKitAsset.Colors.dark.color
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cv.allowsMultipleSelection = true
        return cv
    }()
    private lazy var dreamStorageCollectionView: UICollectionView = {
        let layout = self.createStorageLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = RDDSKitAsset.Colors.dark.color
        cv.bounces = false
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cv.allowsMultipleSelection = true
        return cv
    }()
    private lazy var emptyBackgroundView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.tintColor = .clear
        v.isUserInteractionEnabled = false
        return v
    }()
    private var storageHeader: StorageHeaderCVC?
    
    // MARK: - Reactive Stuff
    private let emotionTapped = BehaviorRelay<Int>(value: 0)
    private var selectedIndex = PublishRelay<Int>()
    private let fetchedCount = PublishRelay<Int>()
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
    }
}

// MARK: - UI
extension StorageVC {
    private func setupView() {
        self.view.backgroundColor = RDDSKitAsset.Colors.dark.color
        self.view.addSubviews(logoView, dreamFilterCollectionView, dreamStorageCollectionView, emptyBackgroundView)
    }
    private func setupConstraint() {
        self.logoView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(18)
            make.height.equalTo(23.adjustedHeight)
        }
        self.dreamFilterCollectionView.snp.makeConstraints { make in
            make.height.equalTo(93.adjustedHeight)
            make.top.equalTo(logoView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }
        self.dreamStorageCollectionView.snp.makeConstraints { make in
            make.height.equalTo(477.adjustedHeight)
            make.top.equalTo(dreamFilterCollectionView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
        }
        self.emptyBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(dreamStorageCollectionView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    private func setDelegate() {
        self.dreamFilterCollectionView.dataSource = self
        self.dreamFilterCollectionView.delegate = self
        self.dreamStorageCollectionView.delegate = self
    }
    private func registerView() {
        DreamWriteHeader.register(target: self.dreamFilterCollectionView)
        DreamWriteEmotionCVC.register(target: self.dreamFilterCollectionView)
        StorageHeaderCVC.register(target: self.dreamStorageCollectionView)
        StorageExistCVC.register(target: self.dreamStorageCollectionView)
    }
    
    private func resetView() {
        guard let rdtabbarController = self.tabBarController as? RDTabBarController else { return }
        rdtabbarController.setTabBarHidden(false)
    }
}

// MARK: - DataSource
extension StorageVC {
    private func setDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource<DreamStorageSection, AnyHashable>(collectionView: dreamStorageCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            if indexPath.section == 0 {
                if let model = itemIdentifier as? DreamStorageEntity.RecordList.Record {
                    guard let existCell = collectionView.dequeueReusableCell(withReuseIdentifier: StorageExistCVC.reuseIdentifier, for: indexPath) as? StorageExistCVC else { return UICollectionViewCell() }
                    let currentRecord = model
                    existCell.setupConstraint(layoutType: self.currentLayoutType)
                    var validTitle = currentRecord.title ?? ""
                    if validTitle.count > 25 {
                        validTitle = "\(validTitle.prefix(25))..."
                    }
                    existCell.setData(emotion: currentRecord.emotion ?? 0,
                                      date: currentRecord.date ?? "",
                                      title: "\(validTitle)",
                                      tag: currentRecord.genre ?? [],
                                      layoutType: self.currentLayoutType)
                    return existCell
                }
            }
            return UICollectionViewCell()
        })
        
        self.dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            if kind == StorageHeaderCVC.className {
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
            }
            else {
                return UICollectionReusableView()
            }
        }
    }
    
    private func applySnapshot(model: DreamStorageEntity.RecordList?) {
        guard let model = model else { return }
        var snapshot = NSDiffableDataSourceSnapshot<DreamStorageSection, AnyHashable>()
        self.fetchedCount.accept(model.recordsCount)
        snapshot.appendSections([.records])
        if model.recordsCount == 0 {
            self.dreamStorageCollectionView.setEmptyView(message: "아직 기록된 꿈이 없어요.", image: UIImage())
            self.dreamStorageCollectionView.isScrollEnabled = false
        } else {
            self.dreamStorageCollectionView.restore()
            self.dreamStorageCollectionView.isScrollEnabled = true
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
                                                filterButtonTapped: self.emotionTapped.skip(1).asObservable(), viewWillAppear: self.rx.viewWillAppear)
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
                navigation.isNavigationBarHidden = true
                guard let rdtabbarController = owner.tabBarController as? RDTabBarController else { return }
                rdtabbarController.setTabBarHidden()
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
            .bind(onNext: { [weak self] idx in
                guard let self = self else { return }
                guard let id = self.viewModel.fetchedDreamRecord.records.safeget(index: idx)?.id else { return }
                let detailVC = self.factory.instantiateDetailVC(dreamId: id)
                self.present(detailVC, animated: true)
            }).disposed(by: self.disposeBag)
    }
}

extension StorageVC: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    }
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == DreamWriteHeader.className {
            guard let filterHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DreamWriteHeader.className, for: indexPath) as? DreamWriteHeader else { return UICollectionReusableView() }
            let sectionType = DreamStorageSection.type(indexPath.section)
            filterHeaderView.title = sectionType.title
            return filterHeaderView
        }
        else {
            return UICollectionReusableView()
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if collectionView == dreamFilterCollectionView {
            var selectedIndexPath: IndexPath? = nil
            selectedIndexPath = collectionView.indexPathsForSelectedItems?
                .first { $0.section == indexPath.section }
            self.emotionTapped.accept(indexPath.item)
            guard let selected = selectedIndexPath else { return true }
            collectionView.deselectItem(at: selected, animated: false)
            return true
        }
        else if collectionView == dreamStorageCollectionView {
            self.selectedIndex.accept(indexPath.row)
            return true
        }
        else {
            return false
        }
    }
    public func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        if collectionView == dreamFilterCollectionView {
            return true
        }
        else {
            return false
        }
    }
}
