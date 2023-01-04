//
//  DetailDreamResponse.swift
//  RD-Network
//
//  Created by 김수연 on 2023/01/04.
//  Copyright © 2023 RecorDream-iOS. All rights reserved.
//

import Foundation

public struct DetailDreamResponse: Codable {
    public let id, writer, date, title: String
    public let voice: Voice?
    public let content: String?
    public let emotion: Int
    public let genre: [Int]
    public let note: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case writer, date, title, voice, content, emotion
        case genre, note
    }
}

extension DetailDreamResponse {
    public struct Voice: Codable {
        public let id: String
        public let url: String

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case url
        }
    }
}
