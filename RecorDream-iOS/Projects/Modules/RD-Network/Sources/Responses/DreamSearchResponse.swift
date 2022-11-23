//
//  DreamSearchResponse.swift
//  RD-Network
//
//  Created by 정은희 on 2022/11/08.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

public struct DreamSearchResponse: Decodable {
    public let query: String
    public let results: [DreamSearchResult]
}

public extension DreamSearchResponse {
    struct DreamSearchResult: Decodable {
        private enum CodingKeys: String, CodingKey {
            case recordsCount = "records_count"
            case records
        }
        
        public let recordsCount: Int
        public let records: [Records]
    }
    
    struct Records: Decodable {
        private enum CodingKeys: String, CodingKey {
            case id = "_id"
            case dreamColor = "dream_color"
            case emotion, date, title, genre
        }
        public enum Genre: Int, Decodable {
            case comedy
            case romance
            case action
            case thriller
            case mystery
            case fear
            case sf
            case fantasy
            case family
            case etc
            case none
        }
        
        public let id: String?
        public let dreamColor: Int?
        public let emotion: Int?
        public let date: String?
        public let title: String?
        public let genre: Genre?
    }
}
