//
//  DreamWriteEntity.swift
//  RD-Navigator
//
//  Created by Junho Lee on 2022/09/29.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

public struct DreamWriteRequest: Codable {
    public var title: String? = nil
    public let date: String
    public var content: String? = nil
    public var emotion: Int? = nil
    public var genre: [Int] = []
    public var note: String? = nil
    public var voice: String? = nil
    
    public init(title: String?, date: String, content: String?, emotion: Int?, genre: [Int], note: String?, voice: String?) {
        self.title = title
        self.date = date
        self.content = content
        self.emotion = emotion
        self.genre = genre
        self.note = note
        self.voice = voice
    }
    
    public func makeEmptyFileds() -> Self {
        var newContent = (content == "무슨 꿈을 꾸셨나요?" ? nil : content)
        var newNote = (note == "꿈에 대해 따로 기록할 게 있나요?" ? nil : note)
        return .init(title: title,
                     date: date,
                     content: newContent,
                     emotion: emotion,
                     genre: genre,
                     note: newNote,
                     voice: voice)
    }
}
