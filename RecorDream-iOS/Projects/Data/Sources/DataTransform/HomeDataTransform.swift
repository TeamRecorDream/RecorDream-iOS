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
        return .init(recordId: self.id, emotion: self.emotion, date: self.date, title: self.title, genres: self.genre.map { HomeEntity.toGenreString(num: $0) }, content: self.content ?? "기록된 내용이 없어요.", isExistVoice: self.isExistVoice)
    }
}

