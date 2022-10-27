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
    
    public var genreList: [Int] {
        return self.genres.enumerated()
            .map { ($0.offset, $0.element.isSelected) }
            .filter { $0.1 == true }
            .map { $0.0 }
    }
    
    public var shouldeShowWarning: Bool {
        return genreList.count >= 3
    }
    
    public func toRequest() -> DreamWriteRequest {
        let emotionIndex = self.emotions.firstIndex(where: { $0.isSelected })
        
        return DreamWriteRequest.init(title: self.main.titleText,
                                      date: self.main.date,
                                      content: self.main.contentText,
                                      emotion: emotionIndex,
                                      genre: self.genreList,
                                      note: self.note.noteText,
                                      voice: nil)
    }
}

public extension DreamWriteEntity {
    struct Main: Hashable {
        public let titleText: String
        public let contentText: String
        public let recordTime: CGFloat?
        public let date: String
        
        public init(titleText: String, contentText: String, recordTime: CGFloat?, date: String) {
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
