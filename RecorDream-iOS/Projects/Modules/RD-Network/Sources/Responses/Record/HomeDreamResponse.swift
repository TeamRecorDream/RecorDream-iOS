//
//  HomeDreamResponse.swift
//  RD-Network
//
//  Created by 김수연 on 2023/01/03.
//  Copyright © 2023 RecorDream-iOS. All rights reserved.
//

import Foundation

public struct HomeDreamResponse: Codable {
    public let nickname: String
    public let records: [Records]
}

extension HomeDreamResponse {
    public struct Records: Codable {
        public let id: String
        public let emotion: Int
        public let date: String
        public let title: String
        public let genre: [Int]
        public let content: String?

        private enum CodingKeys: String, CodingKey {
            case id = "_id"
            case emotion, date, title, genre, content
        }
    }
}
