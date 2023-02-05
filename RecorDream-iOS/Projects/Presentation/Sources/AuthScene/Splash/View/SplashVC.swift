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
import RD_Logger
import RD_Network

import RxSwift

public final class SplashVC: UIViewController {
    
    private let authView = AuthView()
    private let disposeBag = DisposeBag()
    public var factory: ViewControllerFactory!
    public var viewModel: SplashViewModel!
    
    private let versionCheckTrigger = PublishSubject<Void>()
    private let delayTrigger = PublishSubject<Void>()
    
    // MARK: - View Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.setupConstraint()
        self.bindViewModels()
    }
}

// MARK: - Extensions
extension SplashVC: AuthControllable {
    func setupView() {
        self.view.addSubview(authView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            UIView.animate(withDuration: 0.8, delay: 1) {
                self.modalTransitionStyle = .partialCurl
                self.delayTrigger.onNext(())
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
    
    func bindViewModels() {
        let checkVersion = Observable.merge(
            Observable.just(()),
            versionCheckTrigger.asObservable()
        )
        
        let input = SplashViewModel.Input(checkVersion: checkVersion)
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
        
        let delayedVersionCheckResult = Observable.combineLatest(
            output.versionChecked,
            delayTrigger.asObservable()
        ).map { $0.0 }
        
        delayedVersionCheckResult
            .withUnretained(self)
            .subscribe { owner, result in
                switch result {
                case .noNeedToUpdate:
                    owner.setupViewState()
                case .forceUpdate:
                    owner.showForceUpdateAlert()
                case let .recommendUpdate(version):
                    owner.showRecommendUpdateAlert(recommendedVersion: version)
                case .networkError:
                    owner.showNetworkErrorAlert()
                }
            }.disposed(by: self.disposeBag)
    }
    
    func showForceUpdateAlert() {
        self.makeAlertWithCancelDestructiveWithAction(
            title: "업데이트가 필요합니다",
            message: "원활한 사용을 위해 최신 버전으로의 업데이트가 필요합니다.",
            okActionTitle: "업데이트"
        ) { _ in
            if let url = URL.ExternalURL.appstore {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } cancelAction: { [weak self] _ in
            guard let self = self else { return }
            self.showForceUpdateAlert()
        }
    }
    
    func showRecommendUpdateAlert(recommendedVersion: String) {
        self.makeAlertWithCancelDestructiveWithAction(
            title: "최신 버전이 존재합니다",
            message: "최신 버전으로 업데이트하시면 더욱 원활한 환경에서 서비스를 이용하실 수 있습니다.",
            okActionTitle: "업데이트"
        ) { [weak self] _ in
            guard let self = self else { return }
            if let url = URL.ExternalURL.appstore {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            self.setupViewState()
        } cancelAction: { [weak self] _ in
            guard let self = self else { return }
            self.setupViewState()
        }
        
        DefaultUserDefaultManager.set(
            value: recommendedVersion,
            keyPath: .checkedAppVersion
        )
    }
    
    func showNetworkErrorAlert() {
        self.makeAlert(
            title: "네트워크 에러",
            message: "네트워크 연결 상태를 확인해주세요"
        ) { [weak self] okAction in
            guard let self = self else { return }
            self.versionCheckTrigger.onNext(())
        }
    }
}

extension SplashVC {
    private func setupViewState() {
        self.checkLoginEnable { loginEnabled in
            switch loginEnabled {
            case true:
                AnalyticsManager.setFirebaseUserProperty()
                self.presentMainTabBar()
            case false:
                self.presentLoginVC()
            }
        }
    }
    
    private func presentMainTabBar() {
        let mainTabBar = self.factory.instantiateMainTabBarController()
        let navigation = UINavigationController(rootViewController: mainTabBar)
        UIApplication.setRootViewController(window: UIWindow.keyWindowGetter!, viewController: navigation, withAnimation: true)
    }
    
    private func presentLoginVC() {
        let loginVC = self.factory.instantiateLoginVC()
        loginVC.modalPresentationStyle = .overFullScreen
        loginVC.modalTransitionStyle = .crossDissolve
        self.present(loginVC, animated: true)
    }
    
    private func checkLoginEnable(completion: @escaping ((Bool) -> Void)) {
        if DefaultUserDefaultManager.string(key: .userToken) != nil &&
            DefaultUserDefaultManager.string(key: .accessToken) != nil {
            DefaultAuthService.shared.reissuance()
                .subscribe(onNext: { response in
                    guard let response = response else {
                        completion(false)
                        return
                    }
                    
                    let isStillValidToken = (response.status == 403)
                    if isStillValidToken {
                        completion(true)
                        return
                    }
                    
                    guard let token = response.data else {
                        completion(false)
                        return
                    }
                    
                    DefaultUserDefaultManager.set(value: token.accessToken, keyPath: .accessToken)
                    DefaultUserDefaultManager.set(value: token.refreshToken, keyPath: .refreshToken)
                    completion(true)
                })
                .disposed(by: self.disposeBag)
        }
        else {
            completion(false)
        }
    }
}
