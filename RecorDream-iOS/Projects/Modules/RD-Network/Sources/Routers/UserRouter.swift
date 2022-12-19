//
//  UserRouter.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Alamofire

enum UserRouter {
    case fetchUserInfo
    case withdrawal
    case changeNickname(nickname: String)
}

extension UserRouter: BaseRouter {
    var method: HTTPMethod {
        switch self {
        case .withdrawal: return .delete
        case .changeNickname: return .put
        default: return .get
        }
    }
    
    var path: String {
        switch self {
        case .changeNickname: return "/user/nickname"
        default: return "/user"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .changeNickname(let nickname):
            let body: [String: Any] = [
                "nickname": nickname
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

