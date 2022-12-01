//
//  SplashVC.swift
//  Presentation
//
//  Created by 정은희 on 2022/12/01.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

public final class SplashVC: UIViewController {

    private let authView = AuthView()
    
    // MARK: - View Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        self.setupConstraint()
    }
}

// MARK: - Extensions
extension SplashVC: AuthControllable {
    func setupView() {
        self.view.addSubview(authView)
    }
    
    func setupConstraint() {
        self.authView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
    }
}
