//
//  RecordRouter.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import Alamofire

enum RecordRouter {
    case writeRecord(title: String, date: String, content: String, emotion: Int, genre: [Int], note: String?, voice: URL?)
}

extension RecordRouter: BaseRouter {
    var method: HTTPMethod {
        switch self {
        case .writeRecord:
            return .post
        default: return .get
        }
    }
    
    var path: String {
        switch self {
        case .writeRecord:
            return "/record"
        default: return ""
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .writeRecord(let title, let date, let content, let emotion, let genre, _, _):
            let requestBody: [String: Any] = [
                "title": title,
                "date": date,
                "content": content,
                "emotion": emotion,
                "genre": genre
            ]
            return .requestBody(requestBody)
        default: return .requestPlain
        }
    }
}
