//
//  DefaultMyPageRepository.swift
//  PresentationTests
//
//  Created by Junho Lee on 2022/10/09.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Domain
import RD_Core
import RD_Network

import RxSwift

public class DefaultMyPageRepository {
    
    private let disposeBag = DisposeBag()
    private var authService: AuthService
    private var userService: UserService
    
    public init(authService: AuthService, userService: UserService) {
        self.authService = authService
        self.userService = userService
    }
}

extension DefaultMyPageRepository: MyPageRepository {
    public func fetchUserInformation() -> Observable<MyPageEntity> {
        return Observable.create { observer in
            self.userService.fetchUserInfo()
                .subscribe(onNext: { response in
                    guard let entity = response?.toDomain() else {
                        return
                    }
                    observer.onNext(entity)
                }, onError: { err in
                    observer.onError(err)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    public func userLogout() -> Observable<Bool> {
        return Observable.create { observer in
            guard let fcmToken = DefaultUserDefaultManager.string(key: UserDefaultKey.userToken) else { return Disposables.create() }
            self.authService.logout(fcmToken: fcmToken)
                .subscribe(onNext: { logoutSuccess in
                    guard logoutSuccess else {
                        observer.onNext(false)
                        return
                    }
                    DefaultUserDefaultManager.clearUserData()
                    observer.onNext(true)
                }, onError: { err in
                    observer.onError(err)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    public func userWithdrawal() -> Observable<Bool> {
        return Observable.create { observer in
            self.userService.withDrawal()
                .subscribe(onNext: { withDrawalSuccess in
                    guard withDrawalSuccess else {
                        observer.onNext(false)
                        return
                    }
                    DefaultUserDefaultManager.clearUserData()
                    observer.onNext(true)
                }, onError: { err in
                    observer.onError(err)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    public func enablePushNotice(time: String) -> Observable<String> {
        return Observable.create { observer in
            observer.onNext("AM 08:20")
            return Disposables.create()
        }
    }
    
    public func disablePushNotice() -> Observable<Void> {
        return Observable.create { observer in
            observer.onNext(())
            return Disposables.create()
        }
    }
}
