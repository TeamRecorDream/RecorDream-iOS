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
}
