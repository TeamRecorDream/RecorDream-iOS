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
        return .init(recordId: self.id, date: self.date, title: self.title, content: self.contents, emotion: self.emotion, genre: self.genre.map { toGenreString(num: $0) }, note: self.noteContent, voiceUrl: self.voiceUrl)
    }

    func toGenreString(num: Int) -> String {
        switch HomeEntity.Genre(rawValue: num) {
        case .장르없음: return "#아직 설정되지 않았어요"
        case .코미디: return "#코미디"
        case .로맨스: return "#로맨스"
        case .판타지: return "#판타지"
        case .공포: return "#공포"
        case .동물: return "#동물"
        case .친구: return "#친구"
        case .가족: return "#가족"
        case .음식: return "음식"
        case .일: return "일"
        case .기타: return "기타"
        case .none: return ""
        }
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

