//
//  StorageHeaderCVC.swift
//  Presentation
//
//  Created by 정은희 on 2022/12/08.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_Core
import RD_DSKit

import RxSwift
import RxCocoa
import SnapKit

final class StorageHeaderCVC: UICollectionReusableView, UICollectionReusableViewRegisterable {
    // MARK: - Properties
    public static var isFromNib: Bool = false
    
    public lazy var title = "" {
        didSet {
            self.countLabel.text = self.title
        }
    }
    
    public var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - UI Components
    private lazy var countLabel: UILabel = {
        let lb = UILabel()
        lb.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 12)
        lb.textAlignment = .left
        lb.textColor = RDDSKitAsset.Colors.white01.color
        return lb
    }()
    private lazy var segmentControl = RDStorageSegmentControl(items: ["", ""])
    
    public lazy var layoutTypeChanged: Driver<RDCollectionViewFlowLayout.CollectionDisplay> = {
        return segmentControl.rx.selectedSegmentIndex
            .map {
                return ($0 == 0)
                ? RDCollectionViewFlowLayout.CollectionDisplay.grid
                : RDCollectionViewFlowLayout.CollectionDisplay.list
            }.asDriver(onErrorJustReturn: .list)
    }()
    
    public var currentType: RDCollectionViewFlowLayout.CollectionDisplay = .grid {
        didSet {
            if self.currentType == .grid {
                self.segmentControl.selectedSegmentIndex = 0
            } else {
                self.segmentControl.selectedSegmentIndex = 1 }
        }
    }
    
    // MARK: - View Life Cycle
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupConstraint()
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
    // MARK: - Functions
    private func setupView() {
        self.addSubviews(countLabel, segmentControl)
        self.backgroundColor = .clear
    }
    private func setupConstraint() {
        self.countLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview()
        }
        
        self.segmentControl.snp.makeConstraints { make in
            make.width.equalTo(55.adjustedWidth)
            make.height.equalTo(24.adjustedHeight)
            make.top.bottom.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(18)
        }
    }
}
