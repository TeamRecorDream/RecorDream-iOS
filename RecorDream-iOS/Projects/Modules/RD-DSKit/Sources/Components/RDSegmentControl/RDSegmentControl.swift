//
//  RDSegmentControl.swift
//  RD-DSKit
//
//  Created by 정은희 on 2022/12/08.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

public class RDSegmentControl: UISegmentedControl {
    private lazy var rdCollectionViewFlowLayout = RDCollectionViewFlowLayout(display: .grid)
    
    public override init(items: [Any]?) {
        super.init(items: items)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setTarget()
        self.setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RDSegmentControl {
    private func setTarget() {
        self.addTarget(self, action: #selector(layoutValueChanged), for: .valueChanged)
    }
    private func setupView() {
        self.backgroundColor = .clear
        self.setImage(RDDSKitAsset.Images.icnGalleryOff.image, forSegmentAt: 1)
        self.setImage(RDDSKitAsset.Images.icnGalleryOff.image, forSegmentAt: 2)
        self.tintColor = RDDSKitAsset.Colors.white04.color
        self.selectedSegmentTintColor = RDDSKitAsset.Colors.white01.color
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
