//
//  AuthRouter.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Alamofire

import RD_Core

enum AuthRouter {
    case login(kakaoToken: String?, appleToken: String?, fcmToken: String)
    case logout
    case reissuance
    case version
}

extension AuthRouter: BaseRouter {
    
    var header: HeaderType {
        switch self {
        case .version:
            return .default
        case .reissuance:
            return .reissuance
        default: return .withToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login, .reissuance, .logout:
            return .post
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .logout:
            return "/auth/logout"
        case .reissuance:
            return "/auth/token"
        case .version:
            return "/version"
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
        default: return .requestPlain
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
}

