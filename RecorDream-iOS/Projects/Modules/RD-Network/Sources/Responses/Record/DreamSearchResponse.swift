//
//  DreamSearchResponse.swift
//  RD-Network
//
//  Created by 정은희 on 2022/11/08.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

public struct DreamSearchResponse: Codable {
    public let recordsCount: Int
    public let records: [Records]
}

extension DreamSearchResponse {
    public struct Records: Codable {
        public let id: String?
        public let emotion: Int?
        public let date: String?
        public let title: String?
        public let genre: [Int]?
        
        private enum CodingKeys: String, CodingKey {
            case id = "_id"
            case emotion, date, title, genre
        }
    }
}
