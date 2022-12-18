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
    public var factory: ViewControllerFactory!
    
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
            switch tokenState {
            case .valid:
                // TODO: - 홈 뷰로 전환
                self.presentMainTabBar()
            case .invalid:
                // TODO: - 로그인 뷰로 전환
                self.presentLoginVC()
            case .missed:
                // TODO: - state에 따라 화면전환
                self.postLogin { success in
                    success
                    ? self.presentMainTabBar()
                    : self.presentLoginVC()
                }
            }
        }
    }
    
    private func presentMainTabBar() {
        let mainTabBar = self.factory.instantiateMainTabBarController()
        let navigation = UINavigationController(rootViewController: mainTabBar)
        navigation.modalPresentationStyle = .overFullScreen
        self.present(navigation, animated: true)
    }
    
    private func presentLoginVC() {
        let loginVC = self.factory.instantiateLoginVC()
        loginVC.modalPresentationStyle = .overFullScreen
        loginVC.modalTransitionStyle = .crossDissolve
        self.present(loginVC, animated: true)
    }
    
    private func checkLoginEnable(completion: @escaping ((TokenState) -> Void)) {
        if UserDefaults.standard.string(forKey: Key.userToken.rawValue) != nil &&
            UserDefaults.standard.string(forKey: Key.accessToken.rawValue) != nil {
            // TODO: - 홈뷰 서버통신
            /// 성공이라면 토큰 상태로 .valid
            /// 실패라면 토큰 상태로 .invalid 넣어주기
            completion(.valid)
        }
        else {
            completion(.missed)
        }
    }
    
    private func postLogin(completion: @escaping ((Bool) -> Void)) {
        guard let userToken = UserDefaults.standard.string(forKey: Key.userToken.rawValue),
              let accessToken = UserDefaults.standard.string(forKey: Key.accessToken.rawValue) else {
            completion(false)
            return
        }
        
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
