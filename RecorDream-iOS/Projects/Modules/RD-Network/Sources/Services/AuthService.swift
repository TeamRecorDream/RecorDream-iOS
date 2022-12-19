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
    func login(kakaoToken: String?, appleToken: String?, fcmToken: String) -> Observable<AuthResponse?>
    func logout(fcmToken: String) -> Observable<Bool>
    func reissuance() -> Observable<GeneralResponse<ReissuanceResponse>?>
}

public class DefaultAuthService: BaseService {
    public static let shared = DefaultAuthService()
    
    private override init() {}
}

extension DefaultAuthService: AuthService {
    public func reissuance() -> Observable<GeneralResponse<ReissuanceResponse>?> {
        requestObjectInRxWithGeneral(AuthRouter.reissuance)
    }
    
    public func login(kakaoToken: String?, appleToken: String?, fcmToken: String) -> Observable<AuthResponse?> {
        requestObjectInRx(AuthRouter.login(kakaoToken: kakaoToken, appleToken: appleToken, fcmToken: fcmToken))
    }
    
    public func logout(fcmToken: String) -> Observable<Bool> {
        requestObjectInRxWithEmptyResponse(AuthRouter.logout(fcmToken: fcmToken))
    }
}
