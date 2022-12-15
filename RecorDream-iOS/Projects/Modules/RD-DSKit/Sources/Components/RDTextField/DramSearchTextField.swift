//
//  DramSearchTextField.swift
//  RD-DSKit
//
//  Created by 정은희 on 2022/12/15.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

public class DramSearchTextField: UITextField {
    
    // MARK: - Reactive Stuff
    private var disposeBag = DisposeBag()
    public let returnKeyTapped = PublishRelay<Void>()
    public var shouldLoadResult = Observable<String>.of("")
    
    // MARK: - UI Components
    private lazy var iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = RDDSKitAsset.Images.icnSearch.image
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    // MARK: - Initialization
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.bind()
        self.setupView()
        self.setupConstraint()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DramSearchTextField {
    private func bind() {
        self.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .bind(to: returnKeyTapped)
            .disposed(by: disposeBag)
        self.returnKeyTapped
            .asSignal()
            .emit(to: self.rx.endEditing)
            .disposed(by: disposeBag)
        self.shouldLoadResult = returnKeyTapped
            .withLatestFrom(self.rx.text) { $1 ?? "" }
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
    }
    private func setupView() {
        self.backgroundColor = .white.withAlphaComponent(0.05)
        self.clipsToBounds = true
        self.font = RDDSKitFontFamily.Pretendard.medium.font(size: 14.adjusted)
        self.makeRoundedWithBorder(radius: 15, borderColor: UIColor.white.withAlphaComponent(0.1).cgColor)
        self.placeholder = "어떤 기록을 찾고 있나요?"
        self.setPlaceholderColor(UIColor.white.withAlphaComponent(0.4))
        self.setLeftPadding(amount: 52)
        self.addSubview(iconImageView)
        
    }
    private func setupConstraint() {
        self.iconImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(18)
        }
    }
}

extension Reactive where Base: DramSearchTextField {
    var endEditing: Binder<Void> {
        return Binder(base) { base, _ in
            base.endEditing(true)
        }
    }
}
