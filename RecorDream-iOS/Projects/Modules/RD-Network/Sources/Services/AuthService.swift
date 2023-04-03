//
//  AuthService.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation
import RD_Core

import Alamofire
import RxSwift

public protocol AuthService {
    func login(kakaoToken: String?, appleToken: String?, fcmToken: String) -> Observable<AuthResponse?>
    func logout() -> Observable<Bool>
    func reissuance() -> Observable<GeneralResponse<ReissuanceResponse>?>
    func checkVersion() -> Observable<VersionResponse?>
}

public class DefaultAuthService: BaseService {
    public static let shared = DefaultAuthService()
    
    private override init() {}
}

extension DefaultAuthService: AuthService {
    public func checkVersion() -> Observable<VersionResponse?> {
        requestObjectInRx(AuthRouter.version)
    }
    
    public func reissuance() -> Observable<GeneralResponse<ReissuanceResponse>?> {
        requestObjectInRxWithGeneral(AuthRouter.reissuance)
    }
    
    public func reissuance(completion: @escaping ((Bool) -> Void)) {
        AFManager.request(AuthRouter.reissuance)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    guard let decodedData = try? decoder.decode(GeneralResponse<ReissuanceResponse>?.self, from: data) else { return completion(false )}
                    
                    let isStillValidToken = (decodedData.status == 403)
                    if isStillValidToken {
                        print("유효한 토큰")
                        return completion(true)
                    }
                    
                    // body가 존재하면 갱신
                    guard let body = decodedData.data else { return completion(false) }
                    DefaultUserDefaultManager.set(value: body.accessToken, keyPath: .accessToken)
                    DefaultUserDefaultManager.set(value: body.refreshToken, keyPath: .refreshToken)
                    
                    return completion(true)
                default:
                    print("토큰 재발급 에러")
                    return completion(false)
                }
            }
    }
    
    public func login(kakaoToken: String?, appleToken: String?, fcmToken: String) -> Observable<AuthResponse?> {
        requestObjectInRx(AuthRouter.login(kakaoToken: kakaoToken, appleToken: appleToken, fcmToken: fcmToken))
    }
    
    public func logout() -> Observable<Bool> {
        requestObjectInRxWithEmptyResponse(AuthRouter.logout)
    }
}
