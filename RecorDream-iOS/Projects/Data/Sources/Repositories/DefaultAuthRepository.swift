//
//  DefaultAuthRepository.swift
//  Data
//
//  Created by 정은희 on 2022/12/04.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import Domain
import RD_Core
import RD_Network

import RxSwift

public final class DefaultAuthRepository {
    
    private let authService: AuthService
    private let disposeBag = DisposeBag()
    
    public var checkedRecommendVersion: String {
        return DefaultUserDefaultManager.checkedAppVersion ?? "1.0.0"
    }
    
    public init(authService: AuthService) {
        self.authService = authService
    }
}

extension DefaultAuthRepository: AuthRepository {
    public func requestAuth(request: AuthRequest) -> RxSwift.Observable<AuthEntity?> {
        return Observable.create { observer in
            self.authService.login(kakaoToken: request.kakaoToken, appleToken: request.appleToken, fcmToken: request.fcmToken)
                .subscribe(onNext: { response in
                    guard let response = response else { return }
                    DefaultUserDefaultManager.set(value: response.userId, keyPath: .userId)
                    DefaultUserDefaultManager.set(value: response.accessToken, keyPath: .accessToken)
                    DefaultUserDefaultManager.set(value: response.refreshToken, keyPath: .refreshToken)
                    DefaultUserDefaultManager.set(value: response.nickname, keyPath: .nickname)
                    observer.onNext(.init(duplicated: response.duplicated, accessToken: response.accessToken, refreshToken: response.refreshToken, nickname: response.nickname))
                }, onError: { err in
                    observer.onError(err)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    public func requestReissuance() -> Observable<Bool> {
        return Observable.create { observer in
            self.authService.reissuance()
                .subscribe(onNext: { response in
                    guard let response = response else {
                        observer.onNext(false)
                        return
                    }
                    
                    let isStillValidToken = (response.status == 403)
                    if isStillValidToken {
                        observer.onNext(true)
                        return
                    }
                    
                    guard let token = response.data else {
                        observer.onNext(false)
                        return
                    }
                    DefaultUserDefaultManager.set(value: token.accessToken, keyPath: .accessToken)
                    DefaultUserDefaultManager.set(value: token.refreshToken, keyPath: .refreshToken)
                    observer.onNext(true)
                }, onError: { err in
                    observer.onError(err)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    public func checkVersion() -> Observable<VersionCheckEntity?> {
        return Observable.create { observer in
            self.authService.checkVersion()
                .subscribe(onNext: { response in
                    guard let response = response else {
                        observer.onNext(nil)
                        return
                    }
                    observer.onNext(response.toDomain())
                }, onError: { err in
                    observer.onError(err)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
