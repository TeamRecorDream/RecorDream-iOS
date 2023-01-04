//
//  HomeDataTransform.swift
//  Data
//
//  Created by 김수연 on 2022/12/03.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import Domain
import RD_Network

extension HomeDreamResponse {
    func toDomain() -> HomeEntity {
        return .init(nickname: self.nickname, records: self.records.map { $0.toDomain() })
    }
}

extension HomeDreamResponse.Records {
    func toDomain() -> HomeEntity.Record {
        return .init(recordId: self.id, emotion: self.emotion, date: self.date, title: self.title, genres: self.genre.map { toGenreString(num: $0) }, content: self.content ?? "기록된 내용이 없어요.")
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
        case .음식: return "#음식"
        case .일: return "#일"
        case .기타: return "#기타"
        case .none: return ""
        }
    }
}

