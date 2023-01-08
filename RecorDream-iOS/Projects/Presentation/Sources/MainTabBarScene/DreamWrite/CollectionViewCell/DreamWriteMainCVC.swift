//
//  DreamWriteMainCVC.swift
//  Presentation
//
//  Created by Junho Lee on 2022/10/05.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import Domain
import RD_Core
import RD_DSKit

import RxSwift
import RxCocoa

final class DreamWriteMainCVC: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    static var isFromNib: Bool = false
    
    public var disposeBag = DisposeBag()
    
    var interactionViewTapped = PublishRelay<DreamWriteInteractionView.InteractionType>()
    
    var titleTextChanged: Observable<String> {
        return titleTextView.rx.text.orEmpty.asObservable()
    }
    
    var contentTextChanged: Observable<String> {
        return contentTextView.rx.text.orEmpty.asObservable()
    }
    
    // MARK: - UI Components
    
    private let dateInteractionView = DreamWriteInteractionView()
        .viewType(.date)
    
    private let voiceRecordInteractionView = DreamWriteInteractionView()
        .viewType(.voiceRecord(isEnabled: false, voiceExist: false))
    
    private let titleTextView = DreamWriteTextView()
        .placeHolder("꿈의 제목을 남겨주세요")
    
    private let contentTextView = DreamWriteTextView()
        .placeHolder("무슨 꿈을 꾸셨나요?")
    
    // MARK: - View Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
        self.setLayout()
        self.setGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
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

// MARK: - Methods

extension DreamWriteMainCVC {
    
    private func setGesture() {
        let dateInteractionViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(interactionViewTapped(_:)))
        let voiceRecordViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(interactionViewTapped(_:)))
        dateInteractionView.addGestureRecognizer(dateInteractionViewTapGesture)
        voiceRecordInteractionView.addGestureRecognizer(voiceRecordViewTapGesture)
    }
    
    public func setData(model: DreamWriteEntity.Main, isModifyView: Bool) {
        self.titleTextView.initText = model.titleText
        self.contentTextView.initText = model.contentText
        
        self.dateChanged(date: model.date)
        self.recordUpdated(record: CGFloat(model.recordTime))
        
        let voiceRecordEnabled = !isModifyView
        self.voiceRecordInteractionView.rx.isInteractionEnabled.onNext(voiceRecordEnabled)
    }
    
    public func dateChanged(date: String) {
        self.dateInteractionView.rx
            .dateUpdated
            .onNext(date)
    }
    
    public func recordUpdated(record: CGFloat) {
        self.voiceRecordInteractionView.rx
            .recordTimeUpdated
            .onNext(record)
    }
    
    @objc
    private func interactionViewTapped(_ sender: UITapGestureRecognizer) {
        guard let senderView = sender.view as? DreamWriteInteractionView else { return }
        switch senderView.viewType {
        case .date:
            if dateInteractionView.isEnabled {
                self.interactionViewTapped.accept(.date)
            }
        case .voiceRecord:
            self.interactionViewTapped.accept(.voiceRecord(isEnabled: voiceRecordInteractionView.isEnabled,
                                                           voiceExist: voiceRecordInteractionView.voiceExist))
        }
    }
}
