//
//  RecordRouter.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Alamofire

enum RecordRouter {
    case WriteRecord(title: String, date: String, contemt: String, emotion: Int, genre: [Int], note: String?, voice: URL?)
}

extension RecordRouter: BaseRouter {
    var method: HTTPMethod {
        switch self {
        default: return .get
        }
    }
    
    var path: String {
        switch self {
        default: return ""
        }
    }
    
    var parameters: RequestParams {
        switch self {
        default: return .requestPlain
        }
    }
}
