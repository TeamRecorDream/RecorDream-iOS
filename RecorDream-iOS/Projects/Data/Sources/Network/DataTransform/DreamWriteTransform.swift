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
                                 contentText: self.content ?? "",
                                 recordTime: "03:00",
                                 date: self.processedDate),
                     emotions: self.emotions,
                     genres: self.genres,
                     note: .init(noteText: self.note ?? ""))
    }
    
    var emotions: [DreamWriteEntity.Emotion] {
        var isSelectedArray = Array(repeating: false, count: 5)
        if self.emotion != 0 {
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
