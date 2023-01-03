//
//  DreamStorageResponse.swift
//  RD-Network
//
//  Created by 정은희 on 2022/12/27.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import Foundation

public struct DreamStorageResponse: Codable {
    public let recordsCount: Int
    public let records: [Record]
}

extension DreamStorageResponse {
    public struct Record: Codable {
        public let id: String
        public let emotion: Int
        public let date: String
        public let title: String
        public let genre: [Int]
        
        private enum CodingKeys: String, CodingKey {
            case id = "_id"
            case emotion, date, title, genre
        }
    }
}
