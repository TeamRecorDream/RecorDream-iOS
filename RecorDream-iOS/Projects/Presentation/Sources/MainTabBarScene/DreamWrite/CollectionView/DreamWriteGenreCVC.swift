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
    
    override var isSelected: Bool {
        didSet { self.updateColor() }
    }
    
    static var isFromNib: Bool = false
    
    private let selectedColor = RDDSKitAsset.Colors.purple.color
    private let deselectedColor = UIColor.white.withAlphaComponent(0.2)
    
    // MARK: - UI Components
    
    private lazy var genreLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        lb.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 14.adjusted)
        lb.textColor = .white.withAlphaComponent(0.2)
        return lb
    }()
    
    // MARK: - View Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DreamWriteGenreCVC {
    private func setUI() {
        self.layer.cornerRadius = 3
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
    }
    
    private func updateColor() {
        genreLabel.textColor = self.isSelected ? self.selectedColor : self.deselectedColor
        self.layer.borderColor = self.isSelected ? self.selectedColor.cgColor : self.deselectedColor.cgColor
    }
    
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
