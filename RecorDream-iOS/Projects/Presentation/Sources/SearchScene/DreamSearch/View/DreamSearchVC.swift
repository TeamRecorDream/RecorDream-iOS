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
            // 1. Entity를 가져온다
            if let model = itemIdentifier as? DreamSearchEntity {
                // 1-1. 처음 탭에 들어온 상태 (서버통신 일어나지 않음),
                if model.records.isEmpty {
                    return UICollectionViewCell() // 1-2. 빈 셀을 보여준다.
                }
                // 2-1. 검색 수행 (엔티티 존재)
                else {
                    switch model.recordsCount {
                    case 0:
                        // 2-2. 검색 결과 존재하지 않는다면 -> 엠티뷰
                        guard let emptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: DreamSearchEmptyCVC.reuseIdentifier, for: indexPath) as? DreamSearchEmptyCVC else { return UICollectionViewCell() }
                        return emptyCell
                    default:
                        // 2-3. 검색 결과가 있다면 -> 목록 띄워줌
                        guard let resultCell = collectionView.dequeueReusableCell(withReuseIdentifier: StorageExistCVC.reuseIdentifier, for: indexPath) as? StorageExistCVC else { return UICollectionViewCell() }
                        // 2-4. 결과 뿌려주는 부분
                        // 셀 선택 시 상세보기로 화면 이동은 bindCollectionView() 함수 내에서 rx로 처리하였음
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
                // 헤더에 검색결과 총개수 표시하는 부분인데 if let model = itemIdentifier로 가져오고 싶은데 우찌 할지 모르겠삼 비동기적으로 업뎃되도록 뷰모델로 빼야되나...?!
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
        let previousItems = snapshot.itemIdentifiers(inSection: .non) // 검색 결과 존재하지 않을때 사용할 아이템
        
        snapshot.appendSections([.exist, .non])
        snapshot.appendItems([], toSection: .exist)
        snapshot.appendItems([], toSection: .non)
        snapshot.deleteItems(previousItems) // 이런 식으로 지워줌 (스냅샷 업데이트)
        self.dataSource.apply(snapshot)
        self.view.setNeedsLayout()
    }
}
// MARK: - Bind
extension DreamSearchVC {
    private func bindViewModels() {
        let input = DreamSearchViewModel.Input(currentSearchQuery: self.searchTextField.shouldLoadResult, returnButtonTapped: self.searchTextField.returnKeyTapped.asObservable())
        // 텍필 내 옵저버블은 디자인킷에 있습니다...!
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
        
        output.searchResultModelFetched
            .withUnretained(self)
            .subscribe(onNext: { strongSelf, entity in
                strongSelf.applySnapShot(model: entity)
            }).disposed(by: self.disposeBag)
//        output.loadingStatus // TODO: - 풀 받고 주석 해제할 것
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
        self.navigationBar.leftButtonTapped
            .withUnretained(self)
            .subscribe(onNext: { owner in
                self.dismiss(animated: true)
            }).disposed(by: disposeBag)
    }
}
