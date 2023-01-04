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
    case writeRecord(title: String, date: String, content: String?, emotion: Int?, genre: [Int]?, note: String?, voice: String?)
    case fetchModifyRecord(recordId: String)
    case modifyRecord(title: String, date: String, content: String?, emotion: Int?, genre: [Int]?, note: String?, voice: String?, recordId: String)
    case searchRecord(keyword: String)
    case fetchStorage(filter: Int)
    case fetchHomeRecord
    case fetchDetailRecord(recordId: String)
    case deleteRecord(recordId: String)
}

extension RecordRouter: BaseRouter {
    var method: HTTPMethod {
        switch self {
        case .writeRecord:
            return .post
        case .modifyRecord:
            return .patch
        case .fetchStorage, .fetchHomeRecord, .fetchDetailRecord:
            return .get
        case .deleteRecord:
            return .delete
        default: return .get
        }
    }

    var path: String {
        switch self {
        case .writeRecord:
            return "/record"
        case .fetchModifyRecord(let recordId):
            return "/record/\(recordId)"
        case .modifyRecord(_, _, _, _, _, _, _, let recordId):
            return "/record/\(recordId)"
        case .searchRecord:
            return "/record/storage/search"
        case .fetchStorage:
            return "/record/storage/list"
        case .fetchHomeRecord:
            return "/record"
        case .fetchDetailRecord(let recordId):
            return "/record/\(recordId)"
        case .deleteRecord(let recordId):
            return "/record/\(recordId)"
        default: return ""
        }
    }

    var parameters: RequestParams {
        switch self {
        case .writeRecord(let title, let date, let content, let emotion, let genre, let note, let voice):
            let requestBody: [String: Any] = [
                "title": title,
                "date": date,
                "content": content,
                "emotion": emotion,
                "genre": genre,
                "note": note,
                "voice": voice
            ]
            return .requestBody(requestBody)
        case .modifyRecord(let title, let date, let content, let emotion, let genre, let note, let voice, _):
            var requestBody: [String: Any] = [
                "title": title,
                "date": date
            ]
            if content != nil {
                requestBody.updateValue(content, forKey: "content")
            }
            if emotion != nil {
                requestBody.updateValue(emotion, forKey: "emotion")
            }
            if genre != nil {
                requestBody.updateValue(genre, forKey: "genre")
            }
            if note != nil {
                requestBody.updateValue(note, forKey: "note")
            }
            if voice != nil {
                requestBody.updateValue(voice, forKey: "voice")
            }
            return .requestBody(requestBody)
        case .searchRecord(let keyword):
            let query: [String: Any] = [
                "keyword": keyword
            ]
            return .query(query, parameterEncoding: parameterEncoding)
        case .fetchStorage(let filter):
            let query: [String: Any] = [
                "filter": filter
            ]
            return .query(query, parameterEncoding: parameterEncoding)
        default: return .requestPlain
        }
    }

    var parameterEncoding: ParameterEncoding {
        switch self {
        case .searchRecord, .fetchStorage:
            return URLEncoding.init(destination: .queryString)
        default:
            return JSONEncoding.default
        }
    }
}
