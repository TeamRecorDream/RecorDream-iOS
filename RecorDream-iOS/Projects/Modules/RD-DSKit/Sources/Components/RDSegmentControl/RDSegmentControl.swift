//
//  RDSegmentControl.swift
//  RD-DSKit
//
//  Created by 정은희 on 2022/12/08.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import SnapKit

public protocol RDSegmentControl {
    func setupView()
    func setupConstraint()
}

public class RDStorageSegmentControl: UISegmentedControl, RDSegmentControl {
    private lazy var rdCollectionViewFlowLayout = RDCollectionViewFlowLayout(display: .grid)
    private let lineView: UIView = {
        let v = UIView()
        v.backgroundColor = RDDSKitAsset.Colors.dark.color
        return v
    }()
    
    public override init(items: [Any]?) {
        super.init(items: items)
        
        self.setupView()
        self.setupConstraint()
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RDStorageSegmentControl {
    public func setupView() {
        self.addSubview(lineView)
        self.backgroundColor = RDDSKitAsset.Colors.white04.color
        self.borderColor = .clear
        self.selectedSegmentIndex = 0
        self.setImage(RDDSKitAsset.Images.icnGalleryOn.image, forSegmentAt: 0)
        self.setImage(RDDSKitAsset.Images.icnListOn.image, forSegmentAt: 1)
        self.selectedSegmentTintColor = RDDSKitAsset.Colors.white04.color
        self.tintColor = RDDSKitAsset.Colors.white04.color
    }
    public func setupConstraint() {
        self.lineView.snp.makeConstraints { make in
            make.width.equalTo(1.adjustedWidth)
            make.height.equalTo(10.adjustedHeight)
            make.centerX.centerY.equalToSuperview()
        }
    }
}
