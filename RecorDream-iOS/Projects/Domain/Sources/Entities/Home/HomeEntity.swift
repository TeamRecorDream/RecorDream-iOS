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
}
