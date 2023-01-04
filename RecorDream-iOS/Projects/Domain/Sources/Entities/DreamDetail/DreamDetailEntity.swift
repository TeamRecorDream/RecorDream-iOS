//
//  DreamDetailEntity.swift
//  
//
//  Created by 김수연 on 2022/12/04.
//

import Foundation

public struct DreamDetailEntity {
    public let recordId: String
    public let date: String
    public let title: String
    public let content: String
    public let emotion: Int
    public let genre: [String]
    public let note: String
    public var voiceUrl: URL?

    public init(recordId: String, date: String, title: String, content: String, emotion: Int, genre: [String], note: String, voiceUrl: URL?) {
        self.recordId = recordId
        self.date = date
        self.title = title
        self.content = content
        self.emotion = emotion
        self.genre = genre
        self.note = note
        self.voiceUrl = voiceUrl
    }
}
