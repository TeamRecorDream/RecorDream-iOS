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
    case toggleNoticeStatus(isActive: Bool)
    case postPushTime(time: String)
}

extension UserRouter: BaseRouter {
    var method: HTTPMethod {
        switch self {
        case .withdrawal: return .delete
        case .changeNickname: return .put
        case .toggleNoticeStatus: return .patch
        case .postPushTime: return .post
        default: return .get
        }
    }
    
    var path: String {
        switch self {
        case .changeNickname: return "/user/nickname"
        case .toggleNoticeStatus: return "/user/toggle"
        case .postPushTime: return "/user/notice"
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
        case .toggleNoticeStatus(let isActive):
            let body: [String: Any] = [
                "isActive": isActive
            ]
            return .requestBody(body)
        case .postPushTime(let time):
            let body: [String: Any] = [
                "time": time
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

