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
}

extension UserRouter: BaseRouter {
    var method: HTTPMethod {
        switch self {
        case .withdrawal: return .delete
        default: return .get
        }
    }
    
    var path: String {
        switch self {
        default: return "/user"
        }
    }
    
    var parameters: RequestParams {
        switch self {
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

