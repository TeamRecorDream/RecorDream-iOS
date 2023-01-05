//
//  HomeVC.swift
//  
//
//  Created by 김수연 on 2022/10/23.
//

import UIKit

import Domain
import RD_DSKit
import RD_Core

import RxSwift
import RxCocoa
import SnapKit

/*
 TODO: 추가 로직 구현
 1) 꿈 카드 최대 10개 랜덤
 2) 제목 최대 25자, 텍스트 박스 넘어가면 ... + 생략
 3) 꿈 내용 텍스트 박스 넘어가면 ... + 생략
 */

public class HomeVC: UIViewController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    public var viewModel: HomeViewModel!
    public var factory: ViewControllerFactory!
    
    private var dreamCardCollectionViewAdapter: DreamCardCollectionViewAdapter?
    
    private enum Metric {
        static let logoViewTop = 18.f
        static let logoViewHeight = 24.f
        
        static let mainLabelTop = 44.f
        static let mainLabelLeading = 22.f
        static let mainLabelSpacing = 8.f
        
        static let dreamCardTop = 64.f
        static let dreamCardWidth = 264.f
        static let dreamCardHeight = 392.f
        
        static let minimumLineSpacing = 16.f
    }
    
    // MARK: - UI Components
    
    private let logoView = DreamLogoView()
    private let backgroundView = UIImageView(image: RDDSKitAsset.Images.homeBackground.image)
    
    private var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "반가워요, 드림님!"
        label.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 24.adjusted)
        label.textColor = RDDSKitColors.Color.white
        return label
    }()
    
    private let desciptionLabel: UILabel = {
        let label = UILabel()
        label.text = "그동안 어떤 꿈을 꾸셨나요?"
        label.font = RDDSKitFontFamily.Pretendard.extraLight.font(size: 24.adjusted)
        label.textColor = RDDSKitColors.Color.white
        return label
    }()
    
    private lazy var dreamCardCollectionView: UICollectionView = {
        let layout = CarouselLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        layout.itemSize = CGSize(width: Metric.dreamCardWidth, height: Metric.dreamCardHeight)
        return collectionView
    }()
    
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        self.bindViews()
        self.checkShowDreamWrite()
        self.setUI()
        self.setLayout()
        self.detailDismissNotification()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.bindViewModels()
        self.resetView()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - UI & Layout
    private func setUI() {
        self.view.backgroundColor = RDDSKitAsset.Colors.dark.color
    }
    
    private func setLayout() {
        self.view.addSubviews(backgroundView, logoView, welcomeLabel, desciptionLabel, dreamCardCollectionView)
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        logoView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(Metric.logoViewTop)
            $0.height.equalTo(Metric.logoViewHeight)
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(logoView.snp.bottom).offset(Metric.mainLabelTop)
            $0.leading.equalToSuperview().inset(Metric.mainLabelLeading)
        }
        
        desciptionLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(Metric.mainLabelSpacing)
            $0.leading.equalTo(welcomeLabel.snp.leading)
        }
        
        dreamCardCollectionView.snp.makeConstraints {
            $0.top.equalTo(desciptionLabel.snp.bottom).offset(Metric.dreamCardTop)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Metric.dreamCardHeight)
        }
        
    }
}

// MARK: - Methods

extension HomeVC {
    private func bindViews() {
        self.logoView.rx.mypageButtonTapped
            .withUnretained(self)
            .subscribe(onNext: { (owner, _) in
                let myPageVC = owner.factory.instantiateMyPageVC()
                owner.navigationController?.pushViewController(myPageVC, animated: true)
                guard let rdtabbarController = owner.tabBarController as? RDTabBarController else { return }
                rdtabbarController.rdTabBar.isHidden = true
            }).disposed(by: self.disposeBag)
        
        self.logoView.rx.searchButtonTapped
            .withUnretained(self)
            .subscribe(onNext: { (owner, _) in
                let searchVC = owner.factory.instantiateSearchVC()
                let navigation = UINavigationController(rootViewController: searchVC)
                navigation.modalTransitionStyle = .coverVertical
                navigation.modalPresentationStyle = .fullScreen
                navigation.isNavigationBarHidden = true
                guard let rdtabbarController = owner.tabBarController as? RDTabBarController else { return }
                rdtabbarController.rdTabBar.isHidden = true
                owner.present(navigation, animated: true)
            }).disposed(by: disposeBag)
    }
    
    private func bindViewModels() {
        let input = HomeViewModel.Input(viewWillAppear: Observable.just(()))

        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
        
        
        output.fetchedHomeData
            .compactMap { $0 }
            .withUnretained(self)
            .bind { (owner, entity) in
                owner.fetchHomeData(model: entity)
            }.disposed(by: self.disposeBag)
    }
    
    private func fetchHomeData(model: HomeEntity) {
        self.welcomeLabel.text = "반가워요, \(model.nickname)님!"
        self.viewModel.fetchedDreamRecord = model
        self.dreamCardCollectionViewAdapter = DreamCardCollectionViewAdapter(
            collectionView: self.dreamCardCollectionView, adapterDataSource: self.viewModel)
        self.setCollectionViewAdapter()
    }
    
    private func setCollectionViewAdapter() {
        self.dreamCardCollectionViewAdapter?.selectedIndex
            .compactMap { $0 }
            .withUnretained(self)
            .bind { (owner, index) in
                guard let records = owner.viewModel.fetchedDreamRecord.records.safeget(index: index) else { return }

                let detail = owner.factory.instantiateDetailVC(dreamId: records.recordId)
                owner.present(detail, animated: true)
            }.disposed(by: self.disposeBag)
    }
    
    private func resetView() {
        guard let rdtabbarController = self.tabBarController as? RDTabBarController else { return }
        rdtabbarController.rdTabBar.isHidden = false
    }
    
    private func checkShowDreamWrite() {
        if DefaultUserDefaultManager.shouldShowWrite ?? false {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                DefaultUserDefaultManager.set(value: false, keyPath: .shouldShowWrite)
                let vc = self.factory.instantiateDreamWriteVC(.write)
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }
    }

    private func detailDismissNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didDismissDetailVC(_:)), name: NSNotification.Name(rawValue: "dismissDetail"), object: nil)
    }

    @objc private func didDismissDetailVC(_ notification: Notification) {
        self.viewWillAppear(true)
    }
}
