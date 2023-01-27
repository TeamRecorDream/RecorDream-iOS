//
//  DreamWriteNoteCVC.swift
//  Presentation
//
//  Created by Junho Lee on 2022/10/06.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_Core
import RD_DSKit
import RD_Logger

import RxSwift
import RxCocoa

final class DreamWriteNoteCVC: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    static var isFromNib: Bool = false
    
    public var disposeBag = DisposeBag()
    
    var noteTextChanged: Observable<String> {
        return noteTextView.sharedText
    }
    
    var noteTextBeginEndEditing: Observable<Bool> {
        let observable = Observable.merge(
            noteTextView.didBeginEditing
                .map { _ in true },
            noteTextView.didEndEditing
                .map { _ in false }
        )
        return observable
    }
    
    // MARK: - UI Components
    
    private let noteTextView = DreamWriteTextView()
        .placeHolder("꿈에 대해 따로 기록할 게 있나요?")
    
    // MARK: - View Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
}

extension DreamWriteNoteCVC {
    private func setUI() {
        self.backgroundColor = RDDSKitAsset.Colors.dark.color
    }
    
    private func setLayout() {
        self.addSubviews(noteTextView)
        
        noteTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(240)
            make.bottom.equalToSuperview().inset(78)
        }
    }
    
    public func setData(noteText: String) {
        self.noteTextView.initText = noteText
    }
    
    public func bindViews(source: FirebaseEventType.WriteSource) {
        noteTextView.didBeginEditing
            .subscribe(onNext: { _ in
                AnalyticsManager.log(event: .clickNote(source))
            })
            .disposed(by: self.disposeBag)
    }
}
