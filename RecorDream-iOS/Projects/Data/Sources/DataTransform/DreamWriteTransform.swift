//
//  MyPageDTO.swift
//  PresentationTests
//
//  Created by Junho Lee on 2022/10/09.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Domain
import RD_Network

import Foundation

extension DreamWriteModifyResponse {
    func toDomain() -> DreamWriteEntity {
        return .init(main: .init(titleText: self.title,
                                 contentText: self.validContent,
                                 recordTime: 0.0,
                                 date: self.processedDate),
                     emotions: self.emotions,
                     genres: self.genres,
                     note: .init(noteText: self.validNote))
    }
    
    var validContent: String {
        if let content = self.content {
            return content == ""
            ? "무슨 꿈을 꾸셨나요?"
            : content
        } else {
            return "무슨 꿈을 꾸셨나요?"
        }
    }
    
    var validNote: String {
        if let note = self.note {
            return note == ""
            ? "꿈에 대해 따로 기록할 게 있나요?"
            : note
        } else {
            return "꿈에 대해 따로 기록할 게 있나요?"
        }
    }
    
    var emotions: [DreamWriteEntity.Emotion] {
        var isSelectedArray = Array(repeating: false, count: 5)
        if self.emotion != 6 {
            isSelectedArray[self.emotion - 1] = true
        }
        return isSelectedArray.map { DreamWriteEntity.Emotion.init(isSelected: $0) }
    }
    
    var genres: [DreamWriteEntity.Genre] {
        var isSelectedArray = Array(repeating: false, count: 10)
        if self.genre.first != 0 {
            for selectedItem in self.genre {
                isSelectedArray[selectedItem - 1] = true
            }
        }
        return isSelectedArray.map { DreamWriteEntity.Genre(isSelected: $0) }
    }
    
    var processedDate: String {
        guard let date = self.date.split(separator: " ").first else { return "" }
        return date.replacingOccurrences(of: "/", with: "-")
    }
}
