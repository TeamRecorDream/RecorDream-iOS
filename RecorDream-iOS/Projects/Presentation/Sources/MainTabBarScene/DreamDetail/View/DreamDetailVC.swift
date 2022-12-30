//
//  DreamDetailVC.swift
//  
//
//  Created by 김수연 on 2022/12/04.
//

import UIKit

import Domain
import RD_DSKit

import RxSwift
import SnapKit

public final class DreamDetailVC: UIViewController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    public var viewModel: DreamDetailViewModel!
    public var factory: ViewControllerFactory!
  
    // MARK: - UI Components

    private enum Metric {
        static let grabberConerRadius = 1.f // 디자인한테 물어보기 radius 값을 어디에서도 찾을 수 없었따.
        static let grabberWidth = 38.f
        static let grabberHeight = 3.f
        static let grabberTop = 21.f

        static let headerViewTop = 16.f
        static let headerHeight = 24.f

        static let emotionImageSize = 85.f

        static let emotionImageTop = 39.f
        static let dateLabelTop = 27.f
        static let contentSpacing = 14.f
        static let contentLeadingTrailing = 24.f

        static let genreStackSpacing = 5.f
        static let genreStackHeight = 27.f

        static let pageControllerLeadingTrailing = 24.f
        static let pageContollerBottom = 7.f

        static let logoMarkBottom = 20.f
    }

    private let backgroundCardImage = UIImageView()

    private let grabberView: UIView = {
        let view = UIView()
        view.backgroundColor = RDDSKitAsset.Colors.white03.color
        return view
    }()

    private let headerView = DreamDetailHeaderView()

    private var emotionImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    private var dateLabel: UILabel = {
        let label = UILabel()
        label.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 14)
        label.textAlignment = .center
        label.textColor = RDDSKitColors.Color.white
        return label
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 18)
        label.textColor = RDDSKitColors.Color.white
        label.numberOfLines = 2
        return label
    }()

    private var genreStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        stack.spacing = Metric.genreStackSpacing
        return stack
    }()

    private let logoMark = UIImageView(image: RDDSKitAsset.Images.rdgoroMark.image)

    private lazy var pageViewController = DetailRecordPageViewController(segmentTitles: ["꿈기록", "노트"], on: self)

  
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUI()
        self.setLayout()
        self.bindViewModels()
        self.bindViews()
        self.setData(model: HomeEntity.Record(recordId: "id어쩌구", emotion: 1, date: "2022/11/22 SUN", title: "제목입니다 혹시 제목이 두줄이면 어떻게 될까요ㅍ 아아아아아아아아?", genres: [.로맨스,.코미디], content: "내용입니다"))
        self.setupTabbarControllersChild()
    }

    // MARK: - UI & Layout
    private func setUI() {
        self.view.backgroundColor = RDDSKitAsset.Colors.dark.color
        grabberView.makeRounded(radius: Metric.grabberConerRadius)
        titleLabel.addLabelSpacing(kernValue: -0.36, lineSpacing: 1.17)
    }

    private func setLayout() {
        self.view.addSubviews(backgroundCardImage, grabberView, headerView, emotionImageView, dateLabel, titleLabel, genreStackView, logoMark)

        backgroundCardImage.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }

        grabberView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Metric.grabberTop)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Metric.grabberWidth)
            $0.height.equalTo(Metric.grabberHeight)
        }

        headerView.snp.makeConstraints {
            $0.top.equalTo(grabberView.snp.bottom).offset(Metric.headerViewTop)
            $0.height.equalTo(Metric.headerHeight)
            $0.leading.trailing.equalToSuperview()
        }

        emotionImageView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(Metric.emotionImageTop)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(Metric.emotionImageSize)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(emotionImageView.snp.bottom).offset(Metric.dateLabelTop)
            $0.centerX.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(Metric.contentSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.contentLeadingTrailing)
        }

        genreStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Metric.contentSpacing)
            $0.leading.equalToSuperview().inset(Metric.contentLeadingTrailing)
            $0.height.equalTo(Metric.genreStackHeight)
        }

        logoMark.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(Metric.logoMarkBottom)
        }

        self.view.addSubview(pageViewController)

        pageViewController.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Metric.pageControllerLeadingTrailing)
            $0.top.equalTo(genreStackView.snp.bottom)
            $0.bottom.equalTo(logoMark.snp.top).offset(Metric.pageContollerBottom)
        }
    }

    func setData(model: HomeEntity.Record) {
        // emotion: Int, date: String, title: String, tag: [String], note: String
        backgroundCardImage.image = RDDSKitAsset.Images.backgroundPurple.image
        emotionImageView.image = RDDSKitAsset.Images.feelingLStrange.image
        
        dateLabel.text = model.date
        titleLabel.text = model.title

        if model.genres.isEmpty {
            genreStackView.addArrangedSubview(DreamGenreTagView(type: .detail, genre: "# 아직 설정되지 않았어요"))
        } else {
            model.genres.forEach {
                genreStackView.addArrangedSubview(DreamGenreTagView(type: .detail, genre: $0.rawValue))
            }
        }
    }
}

// MARK: - Methods

extension DreamDetailVC {
    private func bindViewModels() {
        let input = DreamDetailViewModel.Input()
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    }
}

// MARK: - PageController Methods

extension DreamDetailVC {
    private func setupTabbarControllersChild() {
        pageViewController.setTabContentsItem(contentPages: [DreamRecordViewController(), DreamNoteViewController()])
    }

    private func bindViews() {
        self.headerView.rx.moreButtonTapped
            .withUnretained(self)
            .subscribe(onNext: { (owner, _) in
                // TODO: 더 자연스러운 animation
                let detailMoreVC = owner.factory.instantiateDetailMoreVC()

                let navigation = UINavigationController(rootViewController: detailMoreVC)
                navigation.modalTransitionStyle = .coverVertical
                navigation.modalPresentationStyle = .overFullScreen
                navigation.isNavigationBarHidden = true
                owner.present(navigation, animated: false)
            }).disposed(by: self.disposeBag)
    }
}
