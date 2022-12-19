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
    func setTarget()
}

public class RDStorageSegmentControl: UISegmentedControl, RDSegmentControl {
    private lazy var rdCollectionViewFlowLayout = RDCollectionViewFlowLayout(display: .grid)
    private let lineView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    public convenience override init(items: [Any]?) {
        self.init(frame: .zero)
        
        self.setupView()
        self.setupConstraint()
        self.setTarget()
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RDStorageSegmentControl {
    public func setTarget() {
        self.addTarget(self, action: #selector(layoutValueChanged), for: .valueChanged)
    }
    public func setupView() {
        self.addSubview(lineView)
        self.backgroundColor = .clear
        self.selectedSegmentIndex = 1
        self.setImage(RDDSKitAsset.Images.icnGalleryOff.image, forSegmentAt: 1)
        self.setImage(RDDSKitAsset.Images.icnListOff.image, forSegmentAt: 2)
        self.selectedSegmentTintColor = RDDSKitAsset.Colors.white01.color
        self.tintColor = RDDSKitAsset.Colors.white04.color
    }
    public func setupConstraint() {
        self.lineView.snp.makeConstraints { make in
            make.width.equalTo(1.adjustedWidth)
            make.height.equalTo(10.adjustedHeight)
            make.centerX.centerY.equalToSuperview()
        }
    }
    @objc
    private func layoutValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            self.rdCollectionViewFlowLayout.display = .list
        default:
            self.rdCollectionViewFlowLayout.display = .grid
        }
    }
}
