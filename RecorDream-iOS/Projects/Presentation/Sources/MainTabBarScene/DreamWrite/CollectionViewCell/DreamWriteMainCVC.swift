//
//  DreamWriteMainCVC.swift
//  Presentation
//
//  Created by Junho Lee on 2022/10/05.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_Core
import RD_DSKit

import RxSwift
import RxCocoa

final class DreamWriteMainCVC: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    static var isFromNib: Bool = false
    
    var endEditing: Observable<Void> {
        return Observable<Void>.merge([titleTextView.endEditing.asObservable(), contentTextView.endEditing.asObservable()])
    }
    
    // MARK: - UI Components
    
    private let dateInteractionView = DreamWriteInteractionView()
        .viewType(.date)
    
    private let voiceRecordInteractionView = DreamWriteInteractionView()
        .viewType(.voiceRecord)
    
    private let titleTextView = DreamWriteTextView()
        .placeHolder("꿈의 제목을 남겨주세요")
    
    private let contentTextView = DreamWriteTextView()
        .placeHolder("무슨 꿈을 꾸셨나요?")
    
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

extension DreamWriteMainCVC {
    
    private func setUI() {
        self.backgroundColor = RDDSKitAsset.Colors.dark.color
    }
    
    private func setLayout() {
        self.addSubviews(dateInteractionView, voiceRecordInteractionView, titleTextView,
                         contentTextView)
        
        dateInteractionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(54)
        }
        
        voiceRecordInteractionView.snp.makeConstraints { make in
            make.top.equalTo(dateInteractionView.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(54)
        }
        
        titleTextView.snp.makeConstraints { make in
            make.top.equalTo(voiceRecordInteractionView.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(54)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextView.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(360)
            make.bottom.equalToSuperview().inset(30)
        }
    }
}
