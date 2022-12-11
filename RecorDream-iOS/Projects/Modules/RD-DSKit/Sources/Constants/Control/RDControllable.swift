//
//  RDControllable.swift
//  RD-DSKit
//
//  Created by 정은희 on 2022/12/08.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import HeeKit

public protocol DreamControllable: Presentable, Reusable { }

open class DreamCollectionViewCell: UICollectionViewCell, DreamControllable {
    // MARK: - View Life Cycle
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupConstraint()
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    open func setupView() { }
    open func setupConstraint() { }
}

open class DreamReusableView: UICollectionReusableView, DreamControllable {
    // MARK: - View Life Cycle
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupConstraint()
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    open func setupView() { }
    open func setupConstraint() { }
}
