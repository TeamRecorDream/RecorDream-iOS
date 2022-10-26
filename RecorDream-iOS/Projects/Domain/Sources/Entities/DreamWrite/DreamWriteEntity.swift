//
//  DreamWriteEntity.swift
//  Domain
//
//  Created by Junho Lee on 2022/10/26.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

public struct DreamWriteEntity {
    public let main: Main
    public let emotions: [Emotion]
    public let genres: [Genre]
    public let note: Note
    
    public init(main: Main, emotions: [Emotion], genres: [Genre], note: Note) {
        self.main = main
        self.emotions = emotions
        self.genres = genres
        self.note = note
    }
}

public extension DreamWriteEntity {
    struct Main: Hashable {
        public let titleText: String
        public let contentText: String
        public let recordTime: CGFloat?
        public let date: String?
        
        public init(titleText: String, contentText: String, recordTime: CGFloat?, date: String?) {
            self.titleText = titleText
            self.contentText = contentText
            self.recordTime = recordTime
            self.date = date
        }
    }
}

public extension DreamWriteEntity {
    struct Emotion: Hashable {
        let id = UUID()
        public let isSelected: Bool
        
        public init(isSelected: Bool) {
            self.isSelected = isSelected
        }
    }
}

public extension DreamWriteEntity {
    struct Genre: Hashable {
        let id = UUID()
        public let isSelected: Bool
        
        public init(isSelected: Bool) {
            self.isSelected = isSelected
        }
    }
}

public extension DreamWriteEntity {
    struct Note: Hashable {
        public let noteText: String
        
        public init(noteText: String) {
            self.noteText = noteText
        }
    }
}
