//
//  MyPageRepository.swift
//  PresentationTests
//
//  Created by Junho Lee on 2022/10/09.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import RxSwift

public protocol MyPageRepository {
    func fetchUserInformation() -> Observable<MyPageEntity>
    func userLogout() -> Observable<Bool>
    func userWithdrawl() -> Observable<Bool>
    func enablePushNotice(time: String) -> Observable<String>
    func disablePushNotice() -> Observable<Void>
}
