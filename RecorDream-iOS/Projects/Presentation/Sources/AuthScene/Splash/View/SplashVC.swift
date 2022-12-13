//
//  SplashVC.swift
//  Presentation
//
//  Created by 정은희 on 2022/12/01.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import Domain
import RD_Core
import RD_Network

import RxSwift

public final class SplashVC: UIViewController {

    private let authView = AuthView()
    private let disposeBag = DisposeBag()
    
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 1.0, delay: 0) {
                self.setupViewState()
            }
        }
    }
    
    func setupConstraint() {
        self.authView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
    }
}

extension SplashVC {
    private func setupViewState() {
        self.checkLoginEnable { tokenState in
//            switch tokenState {
//            case .valid:
//                // TODO: - 홈 뷰로 전환
//            case .invalid:
//                // TODO: - 로그인 뷰로 전환
//            case .missed:
//                self.postLogin { state in
//                    // TODO: - state에 따라 화면전환
//                }
//            }
        }
    }
    
    private func checkLoginEnable(completion: @escaping ((TokenState) -> Void)) {
        if UserDefaults.standard.string(forKey: Key.userToken.rawValue) != nil &&
            UserDefaults.standard.string(forKey: Key.accessToken.rawValue) != nil {
            // TODO: - 홈뷰 서버통신
            /// 성공이라면 토큰 상태로 .valid
            /// 실패라면 토큰 상태로 .invalid 넣어주기
        }
        else {
            completion(.missed)
        }
    }
    
    private func postLogin(completion: @escaping ((Bool) -> Void)) {
        let userToken = UserDefaults.standard.string(forKey: Key.userToken.rawValue)!
        let accessToken = UserDefaults.standard.string(forKey: Key.accessToken.rawValue)!
        
        DefaultAuthService.shared.login(kakaoToken: userToken, appleToken: userToken, fcmToken: accessToken) // ✅
            .subscribe(onNext: { response in
                guard let response = response else { return }
                DefaultUserDefaultManager.set(value: response.accessToken, keyPath: Key.accessToken.rawValue)
                completion(true)
            }, onError: { _ in
                completion(false)
            }).disposed(by: self.disposeBag)
    }
}
