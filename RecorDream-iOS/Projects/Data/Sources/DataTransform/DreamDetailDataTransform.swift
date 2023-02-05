//
//  DreamDetailDataTransform.swift
//  Data
//
//  Created by 김수연 on 2023/01/04.
//  Copyright © 2023 RecorDream-iOS. All rights reserved.
//

import Foundation

import Domain
import RD_Network

extension DetailDreamResponse {
    func toDomain() -> DreamDetailEntity {
        return .init(recordId: self.id, date: self.date, title: self.title, content: self.contents, emotion: self.emotion, genre: self.genre.map { HomeEntity.toGenreString(num: $0) }, note: self.noteContent, voiceUrl: self.voiceUrl)
    }

    var contents: String {
        guard let contents = self.content else { return "" }
        return contents
    }
    
    var noteContent: String {
        guard let noteContent = self.note else { return "" }
        return noteContent
    }

    var voiceString: String {
        guard let voiceString = self.voice else { return "" }
        return voiceString.url
    }

    var voiceUrl: URL? {
        let url = URL(string: self.voiceString)
        return url ?? nil
    }
}

