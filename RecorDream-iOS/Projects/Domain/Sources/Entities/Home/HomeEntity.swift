//
//  HomeEntity.swift
//  
//
//  Created by 김수연 on 2022/10/23.
//

import Foundation

public struct HomeEntity {
    public let nickname: String
    public let records: [Record]

    public init(nickname: String, records: [Record]) {
        self.nickname = nickname
        self.records = records
    }
}

public extension HomeEntity {
    struct Record: Hashable {
        public let recordId: String
        public let emotion: Int
        public let date: String
        public let title: String
        public let genres: [String]
        public let content: String

        public init(recordId: String, emotion: Int, date: String, title: String, genres: [String], content: String) {
            self.recordId = recordId
            self.emotion = emotion
            self.date = date
            self.title = title
            self.genres = genres
            self.content = content
        }
    }
}

public extension HomeEntity {
    enum Genre: Int {
        case 장르없음
        case 코미디
        case 로맨스
        case 판타지
        case 공포
        case 동물
        case 친구
        case 가족
        case 음식
        case 일
        case 기타
    }

    static func toGenreString(num: Int) -> String {
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
