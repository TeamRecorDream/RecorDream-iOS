//
//  HomeEntity.swift
//  
//
//  Created by 김수연 on 2022/10/23.
//

import Foundation

public struct HomeEntity {
    public let nickname: String
    public let records: [Record]?

    public init(nickname: String, records: [Record]?) {
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
        public let genres: [Genre]
        public let content: String

        public init(recordId: String, emotion: Int, date: String, title: String, genres: [Genre], content: String) {
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
    // 서버에서 Int 배열로 들어오면 장르 케이스 별로 구분해야됨.
    // 로직 고민중
    enum Genre: String{
        case 장르없음 = "# 아직 설정되지 않았어요"
        case 코미디 = "#코미디"
        case 로맨스 = "#로맨스"
    }
}
