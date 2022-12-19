//
//  UserService.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Alamofire

import RxSwift

public protocol UserService {
    func withDrawal() -> Observable<Bool>
    func fetchUserInfo() -> Observable<UserInfoResponse?>
    func changeNickname(nickname: String) -> Observable<Bool>
    func changeNoticeStatus(isActive: Bool) -> Observable<ChangeNoticeStatusResponse?>
    func postNoticeTime(time: String) -> Observable<Bool>
}

public class DefaultUserService: BaseService {
    public static let shared = DefaultUserService()
    
    private override init() {}
}

extension DefaultUserService: UserService {

    public func fetchUserInfo() -> Observable<UserInfoResponse?> {
        requestObjectInRx(UserRouter.fetchUserInfo)
    }
    
    public func withDrawal() -> Observable<Bool> {
        requestObjectInRxWithEmptyResponse(UserRouter.withdrawal)
    }
    
    public func changeNickname(nickname: String) -> RxSwift.Observable<Bool> {
        requestObjectInRxWithEmptyResponse(UserRouter.changeNickname(nickname: nickname))
    }
    
    public func changeNoticeStatus(isActive: Bool) -> RxSwift.Observable<ChangeNoticeStatusResponse?> {
        requestObjectInRx(UserRouter.toggleNoticeStatus(isActive: isActive))
    }
    
    public func postNoticeTime(time: String) -> RxSwift.Observable<Bool> {
        requestObjectInRxWithEmptyResponse(UserRouter.postPushTime(time: time))
    }
}
