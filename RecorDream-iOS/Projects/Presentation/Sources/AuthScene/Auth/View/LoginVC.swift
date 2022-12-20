//
//  LoginVC.swift
//  Presentation
//
//  Created by 정은희 on 2022/12/01.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import Domain
import RD_DSKit

import RxSwift
import RxCocoa
import SnapKit

public final class LoginVC: UIViewController {
    
    // MARK: - UI Components
    private let authView = AuthView()
    private let kakaoLoginButton = RDLoginButton(platform: .kakao, title: "카카오로 시작하기")
    private let appleLoginButton = RDLoginButton(platform: .apple, title: "Apple로 시작하기")
    private let descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.font = RDDSKitFontFamily.Pretendard.regular.font(size: 12)
        lb.text = "로그인 후 이용이 가능합니다."
        lb.textAlignment = .center
        lb.textColor = .white.withAlphaComponent(0.4)
        lb.sizeToFit()
        return lb
    }()
    
    // MARK: - Properties
    public var loginViewModel: LoginViewModel!
    public var factory: ViewControllerFactory!
    var loginRequestFail = PublishSubject<AuthPlatformType>()
    var loginRequestSuccess = PublishSubject<AuthRequest>()
    private let disposeBag = DisposeBag()
    
    // MARK: - View Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.setupConstraint()
        self.bindViewModels()
    }
    
}

// MARK: - Extensions
extension LoginVC: AuthControllable {
    func setupView() {
        self.view.addSubview(authView)
        self.authView.addSubviews(kakaoLoginButton, appleLoginButton, descriptionLabel)
    }
    
    func setupConstraint() {
        self.authView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
        self.kakaoLoginButton.snp.makeConstraints { make in
            make.width.equalTo(343.adjustedWidth)
            make.height.equalTo(52.adjustedHeight)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(614)
        }
        self.appleLoginButton.snp.makeConstraints { make in
            make.width.height.equalTo(kakaoLoginButton)
            make.centerX.equalToSuperview()
            make.top.equalTo(kakaoLoginButton.snp.bottom).offset(8)
        }
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(appleLoginButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - Reactive Part
extension LoginVC {
    private func bindViewModels() {
        let input = LoginViewModel.Input(loginButtonTapped: Observable.merge(
            self.kakaoLoginButton.rx.tap.map { _ in
                AuthPlatformType.kakao
            },
            self.appleLoginButton.rx.tap.map { _ in
                AuthPlatformType.apple
            })
            .asObservable(),
                                         loginRequestFail: loginRequestFail, loginRequestSuccess: loginRequestSuccess)
        
        let output = self.loginViewModel.transform(from: input, disposeBag: self.disposeBag)
        
        output.loginRequest.subscribe(onNext: { [weak self] platformType in
            guard let self = self else { return }
            switch platformType {
            case .kakao:
                self.kakaoLoginAuthentication()
            case .apple:
                self.appleLoginAuthentication()
            }
        }).disposed(by: disposeBag)
        
        output.loginSuccess
            .withUnretained(self)
            .subscribe(onNext: { owner, entity in
            owner.makeMainTabBarToRoot()
        }).disposed(by: self.disposeBag)
        
        output.showLoginFailError.subscribe(onNext: { _ in
            print("로그인 오류")
        }).disposed(by: self.disposeBag)
        
        output.showNetworkError.subscribe(onNext: { _ in
            print("네트워크 오류")
        }).disposed(by: self.disposeBag)
    }
    
    private func makeMainTabBarToRoot() {
        let mainTabBar = self.factory.instantiateMainTabBarController()
        let navigation = UINavigationController(rootViewController: mainTabBar)
        UIApplication.setRootViewController(window: UIWindow.keyWindowGetter!, viewController: navigation, withAnimation: true)
    }
}
