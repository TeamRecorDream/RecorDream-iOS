//
//  DreamWriteEntity.swift
//  RD-Navigator
//
//  Created by Junho Lee on 2022/09/29.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

public struct DreamWriteEntity {
    public let userId: Int
    
    public init(userId: Int) {
        self.userId = userId
    }
}

public struct DreamWriteRequestEntity {
    public let title: String
    public let date: String
    public let content: String
    public let emotion: Int
    public let genre: [Int]
    public let note: String? = nil
    public let voice: URL? = nil
    
    public init(title: String, date: String, content: String, emotion: Int, genre: [Int], note: String?, voice: URL?) {
        self.title = title
        self.date = date
        self.content = content
        self.emotion = emotion
        self.genre = genre
    }
}
