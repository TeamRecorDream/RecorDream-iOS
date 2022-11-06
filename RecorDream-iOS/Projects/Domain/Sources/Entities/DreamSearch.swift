//
//  DreamSearch.swift
//  Domain
//
//  Created by 정은희 on 2022/11/06.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

struct DreamSearchEntity: Codable, Equatable {
    static func == (lhs: DreamSearchEntity, rhs: DreamSearchEntity) -> Bool {
        return lhs.query == rhs.query && lhs.results == rhs.results
    }
    let query: String
    let results: [DreamSearchResult]
}

struct DreamSearchResult: Codable, Equatable {
    static func == (lhs: DreamSearchResult, rhs: DreamSearchResult) -> Bool {
        return lhs.recordsCount == rhs.recordsCount && lhs.records == rhs.records
    }
    let recordsCount: Int
    let records: [Records]
    
    enum CodingKeys: String, CodingKey {
        case recordsCount = "records_count"
        case records
    }
}

struct Records: Codable, Equatable {
    let id: String
    let dreamColor: Int
    let emotion: Int
    let date: String
    let title: String
    let genre: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case dreamColor = "dream_color"
        case emotion, date, title, genre
    }
}
