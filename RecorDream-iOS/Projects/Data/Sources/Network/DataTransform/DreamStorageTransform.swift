//
//  DreamStorageTransform.swift
//  Data
//
//  Created by 정은희 on 2022/12/27.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import Domain
import RD_Network


extension DreamStorageResponse {
    func toDomain() -> DreamStorageEntity.RecordList {
        return .init(recordsCount: self.recordsCount, records: self.records.map { $0.toDomain() })
    }
}

extension DreamStorageResponse.Records {
    func toDomain() -> DreamStorageEntity.RecordList.Records {
        return .init(id: self.id, emotion: self.emotion, date: self.date, title: self.title, genre: self.genre)
    }
}

