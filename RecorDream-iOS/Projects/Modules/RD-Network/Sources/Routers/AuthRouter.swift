//
//  AuthRouter.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Alamofire

enum AuthRouter {
    case login(kakaoToken: String?, appleToken: String?, fcmToken: String)
}

extension AuthRouter: BaseRouter {
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .login(let kakaoToken, let appleToken, let fcmToken):
            let body: [String: Any] = [
                "kakaoToken": kakaoToken,
                "appleToken": appleToken,
                "fcmToken": fcmToken
            ]
            return .requestBody(body)
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
}

