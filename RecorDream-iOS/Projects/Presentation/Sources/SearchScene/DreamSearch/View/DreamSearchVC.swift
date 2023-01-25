//
//  DreamSearchVC.swift
//  Presentation
//
//  Created by 정은희 on 2022/10/10.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import Domain
import RD_DSKit

import RxSwift
import RxCocoa

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
    private lazy var searchTextField = DramSearchTextField()
    private lazy var dreamSearchCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = RDDSKitAsset.Colors.dark.color
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cv.allowsMultipleSelection = true
        return cv
    }()
    private lazy var logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = RDDSKitAsset.Images.rdHomeLogo.image
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .white.withAlphaComponent(0.4)
        return iv
    }()
    
    // MARK: - Reactive Properties
    private let searchKeyword = PublishRelay<String>()
    private let fetchedCount = BehaviorRelay<Int>(value: 0)
    private let selectedIndex = PublishRelay<Int>()
    private let dreamId = PublishRelay<String>()
    private let isModified = PublishRelay<Bool>()
    private var disposeBag = DisposeBag()
    public var factory: ViewControllerFactory!
    public var viewModel: DreamSearchViewModel!
    lazy var dataSource: UICollectionViewDiffableDataSource<DreamSearchResultType, AnyHashable>! = nil
    
    // MARK: - View Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addTapGestureForCollectionView()
        self.setDelegate()
        self.bindCollectionView()
        self.bindDismissButton()
        self.bindTextField()
        self.bindViewModels()
        self.detailDismissNotification()
        self.setupView()
        self.setupConstraint()
        self.setDataSource()
        self.registerXib()
    }
}

// MARK: - UI
extension DreamSearchVC: UITextFieldDelegate {
    public func setupView() {
        self.view.backgroundColor = RDDSKitAsset.Colors.dark.color
        self.view.addSubviews(navigationBar, searchLabel, searchTextField, dreamSearchCollectionView, logoImageView)
    }
    private func setDelegate() {
        self.searchTextField.delegate = self
    }
    public func setupConstraint() {
        self.navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44.adjustedHeight)
        }
        self.searchLabel.snp.makeConstraints { make in
            make.height.equalTo(20.adjustedHeight)
            make.top.equalTo(navigationBar.snp.bottom).offset(34)
            make.leading.equalToSuperview().offset(16)
        }
        self.searchTextField.snp.makeConstraints { make in
            make.height.equalTo(46.adjustedHeight)
            make.width.equalTo(343.adjustedWidth)
            make.centerX.equalToSuperview()
            make.top.equalTo(searchLabel.snp.bottom).offset(16)
        }
        self.dreamSearchCollectionView.snp.makeConstraints { make in
            make.height.equalTo(510.adjustedHeight)
            make.top.equalTo(searchTextField.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        self.logoImageView.snp.makeConstraints { make in
            make.top.equalTo(dreamSearchCollectionView.snp.bottom)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(54)
        }
    }
    private func registerXib() {
        dreamSearchCollectionView.register(DreamSearchHeaderCVC.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DreamSearchHeaderCVC.reuseIdentifier)
        dreamSearchCollectionView.register(DreamSearchExistCVC.self, forCellWithReuseIdentifier: DreamSearchExistCVC.reuseIdentifier)
    }
    private func addTapGestureForCollectionView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOutsideCollectionView))
        tap.numberOfTapsRequired = 1
        self.dreamSearchCollectionView.addGestureRecognizer(tap)
    }
    @objc
    private func didTapOutsideCollectionView(_ recognizer: UITapGestureRecognizer) {
        let tapLocation = recognizer.location(in: self.dreamSearchCollectionView)
        let indexPathForTap = self.dreamSearchCollectionView.indexPathForItem(at: tapLocation)
        let tappedOutOfItems = indexPathForTap == nil
        
        if let row = indexPathForTap?.row {
            self.selectedIndex.accept(row)
        }
        else {
            self.view.endEditing(true)
        }
    }
    private func detailDismissNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didDismissDetailVC(_:)), name: NSNotification.Name(rawValue: "dismissDetail"), object: nil)
    }
    @objc
    private func didDismissDetailVC(_ notification: Notification) {
        self.isModified.accept(true)
    }
}
// MARK: - DataSource
extension DreamSearchVC {
    private func setDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource<DreamSearchResultType, AnyHashable>(collectionView: dreamSearchCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            if let model = itemIdentifier as? DreamSearchEntity.Record {
                guard let resultCell = collectionView.dequeueReusableCell(withReuseIdentifier: DreamSearchExistCVC.reuseIdentifier, for: indexPath) as? DreamSearchExistCVC else { return UICollectionViewCell() }
                var validTitle = model.title ?? ""
                if validTitle.count > 25 {
                    validTitle = "\(validTitle.prefix(25))..."
                }
                resultCell.setData(emotion: model.emotion ?? 0, date: model.date ?? "", title: "\(validTitle)", genre: model.genre ?? [])
                return resultCell
            }
            else {
                collectionView.setEmptyView()
            }
            return UICollectionViewCell()
        })
        
        self.dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DreamSearchHeaderCVC.reuseIdentifier, for: indexPath) as? DreamSearchHeaderCVC else { return UICollectionReusableView() }
                header.configureCell(counts: self.fetchedCount.value)
                return header
            default:
                return UICollectionReusableView()
            }
        }
    }
    private func applySnapShot(model: DreamSearchEntity) {
        var snapshot = NSDiffableDataSourceSnapshot<DreamSearchResultType, AnyHashable>()
        self.fetchedCount.accept(model.recordsCount)
        if model.recordsCount == 0 {
            self.dreamSearchCollectionView.setEmptyView()
        } else {
            self.dreamSearchCollectionView.restore()
            snapshot.appendSections([.exist])
            snapshot.appendItems(model.records, toSection: .exist)
        }
        self.dataSource.apply(snapshot)
        self.view.setNeedsLayout()
    }
}
// MARK: - Bind
extension DreamSearchVC {
    private func bindViewModels() {
        let input = DreamSearchViewModel.Input(currentSearchQuery: self.searchTextField.shouldLoadResult, returnButtonTapped: self.searchTextField.returnKeyTapped.asObservable(), viewWillAppear: self.isModified.asObservable())
        
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
        
        output.searchResultModelFetched
            .compactMap { $0 }
            .withUnretained(self)
            .subscribe(onNext: { owner, entity in
                owner.applySnapShot(model: entity)
            }).disposed(by: self.disposeBag)
        
        output.loadingStatus
            .bind(to: self.rx.isLoading)
            .disposed(by: disposeBag)
        
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
                detailVC.searchedKeyword = self.viewModel.fetchRequestEntity.value.keyword
                self.present(detailVC, animated: true)
            }).disposed(by: self.disposeBag)
    }
    private func bindDismissButton() {
        self.navigationBar.leftButtonTapped
            .withUnretained(self)
            .subscribe(onNext: { owner in
                self.dismiss(animated: true)
            }).disposed(by: disposeBag)
    }
    
    private func bindTextField() {
        self.searchTextField.shouldLoadResult
            .bind(to: self.searchKeyword)
            .disposed(by: self.disposeBag)
    }
}
