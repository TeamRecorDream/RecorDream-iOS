//
//  DefaultAuthRepository.swift
//  Data
//
//  Created by 정은희 on 2022/12/04.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import Domain
import RD_Network

import RxSwift

public final class DefaultAuthRepository {
    
    private let authService: AuthService
    private let disposeBag = DisposeBag()
    
    init(authService: AuthService) {
        self.authService = authService
    }
}

extension DefaultAuthRepository: AuthRepository {
    public func requestAuth(kakaoToken: String, appleToken: String, fcmToken: String) -> RxSwift.Observable<Domain.AuthEntity?> {
        return Observable.create { observer in
            
            self.authService.login(kakaoToken: kakaoToken, appleToken: appleToken, fcmToken: fcmToken)
                .subscribe(onNext: { response in
                    guard let response = response else { return }
                    observer.onNext(.init(duplicated: response.duplicated, accessToken: response.accessToken, refreshToken: response.refreshToken))
                }, onError: { err in
                    observer.onError(err)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    
}
