//
//  DreamWriteGenreCVC.swift
//  Presentation
//
//  Created by Junho Lee on 2022/10/06.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_Core
import RD_DSKit

final class DreamWriteGenreCVC: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    static var isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private lazy var genreLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        lb.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 14.adjusted)
        return lb
    }()
    
    // MARK: - View Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DreamWriteGenreCVC {
    func setLayout() {
        self.addSubviews(genreLabel)
        
        genreLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(6)
            make.top.bottom.equalToSuperview()
        }
    }
    
    func setData(text: String) {
        genreLabel.text = text
        genreLabel.sizeToFit()
    }
}
