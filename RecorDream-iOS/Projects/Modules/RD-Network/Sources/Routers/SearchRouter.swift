//
//  SearchRouter.swift
//  RD-Network
//
//  Created by 정은희 on 2022/11/08.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import Alamofire

enum SearchRouter {
    case searchRecord(keyword: String)
}

extension SearchRouter: BaseRouter {
    var method: HTTPMethod {
        switch self {
        case .searchRecord:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .searchRecord:
            return "/record/storage/search"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .searchRecord(let keyword):
            let query: [String: Any] = [
                "keyword": keyword
            ]
            return .query(query)
        default:
            return .requestPlain
        }
    }
}
