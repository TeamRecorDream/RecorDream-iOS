//
//  AuthService.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Alamofire
import RxSwift

public protocol AuthService {
    func login(kakaoToken: String, appleToken: String, fcmToken: String) -> Observable<AuthResponse?>
}

public class DefaultAuthService: BaseService {
    public static let shared = DefaultAuthService()
    
    private override init() {}
}

extension DefaultAuthService: AuthService {
    public func login(kakaoToken: String, appleToken: String, fcmToken: String) -> RxSwift.Observable<AuthResponse?> {
        requestObjectInRx(AuthRouter.login(kakaoToken: kakaoToken, appleToken: appleToken, fcmToken: fcmToken))
    }
}
