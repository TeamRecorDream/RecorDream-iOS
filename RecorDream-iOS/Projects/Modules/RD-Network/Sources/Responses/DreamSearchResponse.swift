//
//  DreamSearchResponse.swift
//  RD-Network
//
//  Created by 정은희 on 2022/11/08.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

public struct DreamSearchResponse: Codable, Equatable {
    public static func == (lhs: DreamSearchResponse, rhs: DreamSearchResponse) -> Bool {
        return lhs.query == rhs.query && lhs.results == rhs.results
    }
    public let query: String
    public let results: [DreamSearchResult]
}

public struct DreamSearchResult: Codable, Equatable {
    public static func == (lhs: DreamSearchResult, rhs: DreamSearchResult) -> Bool {
        return lhs.recordsCount == rhs.recordsCount && lhs.records == rhs.records
    }
    public let recordsCount: Int
    public let records: [Records]
    
    public enum CodingKeys: String, CodingKey {
        case recordsCount = "records_count"
        case records
    }
}

public struct Records: Codable, Equatable {
    public let id: String
    public let dreamColor: Int
    public let emotion: Int
    public let date: String
    public let title: String
    public let genre: [Int]
    
    public enum CodingKeys: String, CodingKey {
        case id = "_id"
        case dreamColor = "dream_color"
        case emotion, date, title, genre
    }
}
