//
//  DreamSearchTransform.swift
//  Data
//
//  Created by 정은희 on 2022/12/24.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import Domain
import RD_Network

extension DreamSearchResponse {
    func toDomain() -> DreamSearchEntity? {
        return .init(recordsCount: self.recordsCount, records: self.records.map { $0.toDomain() })
    }
}

extension DreamSearchResponse.Records {
    func toDomain() -> DreamSearchEntity.Records {
        return .init(id: self.id, dreamColor: self.dreamColor, emotion: self.emotion, date: self.date, title: self.title, genre: self.genre)
    }
}
