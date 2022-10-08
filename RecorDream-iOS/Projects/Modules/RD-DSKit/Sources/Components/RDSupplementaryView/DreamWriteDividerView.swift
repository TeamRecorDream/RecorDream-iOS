//
//  DreamWriteDivideView.swift
//  RD-DSKit
//
//  Created by Junho Lee on 2022/10/08.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_Core

public class DreamWriteDividerView: UICollectionReusableView, UICollectionReusableViewRegisterable {
    
    // MARK: - Properties
    
    public static var isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.1)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let emptyView = UIView()
    
    // MARK: - View Life Cycles
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: UI & Layout

extension DreamWriteDividerView {
    private func setLayout() {
        self.addSubviews(dividerView, emptyView)
        
        dividerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(2)
        }
        
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom)
            make.height.equalTo(24)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

