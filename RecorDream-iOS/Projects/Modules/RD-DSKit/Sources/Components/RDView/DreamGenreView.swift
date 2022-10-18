//
//  DreamGenreView.swift
//  RD-DSKit
//
//  Created by 정은희 on 2022/10/16.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import HeeKit
import SnapKit

public final class DreamGenreView: UIView {
    public let timeLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = RDDSKitFontFamily.Pretendard.medium.font(size: 8)
        lb.sizeToFit()
        lb.textColor = RDDSKitAsset.Colors.white01.color
        return lb
    }()
    
    // MARK: - View Life Cycle
    public convenience init(genre: String) {
        self.init(frame: .zero)
        
        self.timeLabel.text = genre
        self.updateUI()
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DreamGenreView: Presentable {
    public func setupView() {
        self.backgroundColor = RDDSKitAsset.Colors.white05.color
        self.makeRounded(radius: 3)
        self.addSubview(timeLabel)
    }
    
    public func setupConstraint() {
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().inset(3)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().inset(4)
        }
    }
    private func updateUI() {
        let viewSize = self.timeLabel.intrinsicContentSize
        let width = viewSize.width + 8.adjustedWidth
        let height = viewSize.height + 6.adjustedHeight
        
        self.frame.size = CGSize(width: width, height: height)
        self.timeLabel.center = CGPoint(x: width/2, y: height/2)
    }
}
