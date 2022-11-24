//
//  DreamSearhControllable.swift
//  Presentation
//
//  Created by 정은희 on 2022/10/10.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import HeeKit

public protocol DreamSearhControllable: Presentable, Reusable { }

public class DreamSearchCollectionViewCell: UICollectionViewCell, DreamSearhControllable {
    // MARK: - View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupConstraint()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    public func setupView() { }
    public func setupConstraint() { }
}

public class DreamSearchReusableView: UICollectionReusableView, DreamSearhControllable {
    // MARK: - View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupConstraint()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    public func setupView() { }
    public func setupConstraint() { }
}

public enum DreamSearchResultType: Int {
    case exist
    case non
}
