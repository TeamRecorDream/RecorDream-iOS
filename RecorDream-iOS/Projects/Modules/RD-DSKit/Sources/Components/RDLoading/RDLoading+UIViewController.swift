//
//  RDLoading+UIViewController.swift
//  RD-DSKit
//
//  Created by Junho Lee on 2022/12/20.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import UIKit

import Lottie
import SnapKit
import RxSwift

public extension Reactive where Base: UIViewController {
    var isLoading: Binder<Bool> {
        return Binder(base) { vc, isLoading in
            if isLoading {
                RDLoadingView.shared.show(vc.view)
            } else {
                RDLoadingView.shared.hide()
            }
        }
    }
}

public class RDLoadingView: UIView {
    
    // MARK: - Properties
    
    static let shared = RDLoadingView()
    
    // MARK: - UI Components
    
    private var contentView = UIView()
    
    private var loadingView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "mainLoading.json",
                                                bundle: RDDSKitResources.bundle)
        animationView.loopMode = .loop
        
        return animationView
    }()
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension

extension RDLoadingView {
    private func setLayout() {
        self.addSubview(contentView)
        contentView.addSubview(self.loadingView)
        
        self.contentView.snp.makeConstraints {
            $0.center.equalTo(self.safeAreaLayoutGuide)
        }
        self.loadingView.snp.makeConstraints {
            $0.center.equalTo(self.safeAreaLayoutGuide)
            $0.size.equalTo(150)
        }
    }
    
    private func setUI() {
        self.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
    }
    
    public func show(_ view: UIView) {
        view.addSubview(self)
        
        self.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.layoutIfNeeded()
        self.loadingView.play()
        UIView.animate(
            withDuration: 0.7,
            animations: { self.contentView.alpha = 1 }
        )
    }
    
    public func hide(completion: (() -> Void)? = nil) {
        self.loadingView.stop()
        self.removeFromSuperview()
        completion?()
    }
}
