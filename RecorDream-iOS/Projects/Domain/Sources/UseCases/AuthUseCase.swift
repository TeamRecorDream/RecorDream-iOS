//
//  AuthUseCase.swift
//  Domain
//
//  Created by 정은희 on 2022/12/05.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import RD_Core
import RD_Logger

import RxSwift

public protocol AuthUseCase {
    func login(request: AuthRequest)
    func checkVersion()
    
    var authSuccess: PublishSubject<AuthEntity> { get set }
    var authFail: PublishSubject<Error> { get set }
    var versionChecked: PublishSubject<VersionCheckResult> { get set }
}

public enum VersionCheckResult {
    case networkError
    case recommendUpdate
    case forceUpdate
    case noNeedToUpdate
}

public final class DefaultAuthUseCase {
    private let repository: AuthRepository
    private let disposeBag = DisposeBag()
    
    public var authSuccess = PublishSubject<AuthEntity>()
    public var authFail = PublishSubject<Error>()
    public var versionChecked = PublishSubject<VersionCheckResult>()
    
    public init(repository: AuthRepository) {
        self.repository = repository
    }
}

extension DefaultAuthUseCase: AuthUseCase {
    public func checkVersion() {
        self.repository.checkVersion()
            .withUnretained(self)
            .subscribe { owner, entity in
                guard let entity = entity else {
                    owner.versionChecked.onNext(.networkError)
                    return
                }
                let versionCheckResult = owner.compareVersion(with: entity)
                owner.versionChecked.onNext(versionCheckResult)
            }.disposed(by: self.disposeBag)
    }
    
    private func compareVersion(with versionEntity: VersionCheckEntity) -> VersionCheckResult {
        // 클라이언트의 앱 버전
        guard let currentAppVersion = Bundle.appVersion else {
            return .networkError
        }
        
        // 알림을 확인했던 최신 권장 업데이트 버전
        let checkedNoticeVersion = self.repository.checkedRecommendVersion
        
        // 클라이언트 버전이 강제 업데이트 버전보다 낮은 경우
        let needForceUpdate = currentAppVersion.compare(
            versionEntity.needForceUpdateVersion,
            options: .numeric
        ) == .orderedAscending
        
        guard !needForceUpdate else {
            // 강제 업데이트
            return .forceUpdate
        }
        
        // 클라이언트 버전이 강제 업데이트 버전보다는 높지만 최신 버전보다는 낮은 경우
        let isNotLatestVersion = currentAppVersion.compare(
            versionEntity.latestAppVersion,
            options: .numeric
        ) == .orderedAscending
        
        guard !isNotLatestVersion else {
            // 최신 버전이기 때문에 업데이트 불필요
            return .noNeedToUpdate
        }
        
        // 최신 버전이 아니면서, 권장 업데이트 팝업을 확인하지 않은 경우
        let notChckedUpdateVersion =
        checkedNoticeVersion.compare(
            versionEntity.latestAppVersion,
            options: .numeric
        ) == .orderedAscending
        
        return notChckedUpdateVersion
        ? .recommendUpdate
        : .noNeedToUpdate
    }
    
    public func login(request: AuthRequest) {
        self.repository.requestAuth(request: request)
            .filter { $0 != nil }
            .subscribe(onNext: { [weak self] entity in
                guard let self = self else { return }
                guard let entity = entity else {
                    return }
                self.analytics()
                self.authSuccess.onNext(entity)
            }, onError: { err in
                self.authFail.onNext(err)
            }).disposed(by: disposeBag)
    }
    
    private func analytics() {
        let platForm = DefaultUserDefaultManager.isKakaoUser
        ? FirebaseEventType.LoginSource.kakao
        : FirebaseEventType.LoginSource.apple
        AnalyticsManager.setFirebaseUserProperty()
        AnalyticsManager.log(event: .clickSignIn(platForm))
    }
}
