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

    public init() {
    
    }
}

extension DefaultMyPageRepository: MyPageRepository {
    public func fetchUserInformation() -> Observable<MyPageEntity> {
        return Observable.create { observer in
            observer.onNext(.init(userName: "샘플닉네임",
                                  email: "sample@gmail.com",
                                  pushOnOff: true,
                                  pushTime: "08:00"))
            return Disposables.create()
        }
    }
    
    public func userLogout() -> Observable<Bool> {
        return Observable.create { observer in
            observer.onNext(true)
            return Disposables.create()
        }
    }
    
    public func userWithdrawal() -> Observable<Bool> {
        return Observable.create { observer in
            observer.onNext(true)
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
