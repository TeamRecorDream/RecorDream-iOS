//
//  DreamWriteModifyResponse.swift
//  RD-Network
//
//  Created by Junho Lee on 2022/12/26.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import Foundation

import Foundation

// MARK: - DreamWriteModifyResponse
public struct DreamWriteModifyResponse: Codable {
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

// MARK: - Voice
public struct Voice: Codable {
    public let id, recorder: String
    public let url: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case recorder, url
    }
}
