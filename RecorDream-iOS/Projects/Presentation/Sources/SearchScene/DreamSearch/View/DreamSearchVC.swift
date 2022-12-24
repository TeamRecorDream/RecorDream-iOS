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
    
    // MARK: - Reactive Properties
    private var disposeBag = DisposeBag()
    public var factory: ViewControllerFactory!
    public var viewModel: DreamSearchViewModel!
    lazy var dataSource: UICollectionViewDiffableDataSource<DreamSearchResultType, AnyHashable>! = nil
    
    // MARK: - View Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bindViewModels()
        self.bindCollectionView()
        self.bindDismissButton()
        self.setupView()
        self.setupConstraint()
        self.setDataSource()
        self.registerXib()
    }
}

// MARK: - UI
extension DreamSearchVC {
    public func setupView() {
        self.view.backgroundColor = .black
        self.view.addSubviews(navigationBar, searchLabel, searchTextField, dreamSearchCollectionView)
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
            make.width.equalTo(343.adjustedWidth)
            make.centerX.equalToSuperview()
            make.top.equalTo(searchLabel.snp.bottom).offset(16)
        }
        dreamSearchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    private func registerXib() {
        dreamSearchCollectionView.register(DreamSearchBottomCVC.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: DreamSearchBottomCVC.reuseIdentifier)
        dreamSearchCollectionView.register(DreamSearchHeaderCVC.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DreamSearchHeaderCVC.reuseIdentifier)
        dreamSearchCollectionView.register(DreamSearchEmptyCVC.self, forCellWithReuseIdentifier: DreamSearchEmptyCVC.reuseIdentifier)
        dreamSearchCollectionView.register(StorageExistCVC.self, forCellWithReuseIdentifier: StorageExistCVC.reuseIdentifier)
    }
}
// MARK: - DataSource
extension DreamSearchVC {
    private func setDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource<DreamSearchResultType, AnyHashable>(collectionView: dreamSearchCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            if let model = itemIdentifier as? DreamSearchEntity {
                if model.records.isEmpty {
                    return UICollectionViewCell()
                }
                else {
                    switch model.recordsCount {
                    case 0:
                        guard let emptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: DreamSearchEmptyCVC.reuseIdentifier, for: indexPath) as? DreamSearchEmptyCVC else { return UICollectionViewCell() }
                        return emptyCell
                    default:
                        guard let resultCell = collectionView.dequeueReusableCell(withReuseIdentifier: StorageExistCVC.reuseIdentifier, for: indexPath) as? StorageExistCVC else { return UICollectionViewCell() }
                        resultCell.setData(emotion: model.records[indexPath.row].emotion ?? 0, date: model.records[indexPath.row].date ?? "", title: model.records[indexPath.row].title ?? "", tag: model.records[indexPath.row].genre ?? [])
                        return resultCell
                    }
                }
            }
            else { return UICollectionViewCell() }
        })
        
        self.dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            switch kind {
            case DreamSearchHeaderCVC.className:
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DreamSearchHeaderCVC.reuseIdentifier, for: indexPath) as? DreamSearchHeaderCVC else { return UICollectionReusableView() }
                return header
            case DreamSearchEmptyCVC.className:
                guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DreamSearchEmptyCVC.reuseIdentifier, for: indexPath) as? DreamSearchEmptyCVC else { return UICollectionReusableView() }
                return footer
            default:
                return UICollectionReusableView()
            }
        }
    }
    private func applySnapShot(model: DreamSearchEntity) {
        var snapshot = NSDiffableDataSourceSnapshot<DreamSearchResultType, AnyHashable>()
        let previousItems = snapshot.itemIdentifiers(inSection: .non)
        
        snapshot.appendSections([.exist, .non])
        snapshot.appendItems([], toSection: .exist)
        snapshot.appendItems([], toSection: .non)
        snapshot.deleteItems(previousItems)
        self.dataSource.apply(snapshot)
        self.view.setNeedsLayout()
    }
}
// MARK: - Bind
extension DreamSearchVC {
    private func bindViewModels() {
        let input = DreamSearchViewModel.Input(currentSearchQuery: self.searchTextField.shouldLoadResult, returnButtonTapped: self.searchTextField.returnKeyTapped.asObservable())
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
        
        output.searchResultModelFetched
            .withUnretained(self)
            .subscribe(onNext: { strongSelf, entity in
                strongSelf.applySnapShot(model: entity)
            }).disposed(by: self.disposeBag)
//        output.loadingStatus
//            .bind(to: self.rx.isLoading)
//            .disposed(by: disposeBag)
        
    }
    private func bindCollectionView() {
        self.dreamSearchCollectionView.rx.itemSelected
            .withUnretained(self)
            .subscribe(onNext: { owner in
                // TODO: - 상세보기로 화면전환
            }).disposed(by: disposeBag)
    }
    private func bindDismissButton() {
        self.navigationBar.rightButtonTapped
            .withUnretained(self)
            .subscribe(onNext: { owner in
                self.dismiss(animated: true)
            }).disposed(by: disposeBag)
    }
}
