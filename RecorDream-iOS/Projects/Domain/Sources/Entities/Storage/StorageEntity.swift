//
//  StorageEntity.swift
//  Domain
//
//  Created by 정은희 on 2022/12/24.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

public struct StorageEntity: Equatable {
    public let recordsCount: Int
    public let records: [Records]
    
    public init(recordsCount: Int, records: [Records]) {
        self.recordsCount = recordsCount
        self.records = records
    }
}

extension StorageEntity {
    public struct Records: Equatable {
        let id: String?
        let emotion: Int?
        let date: String?
        let title: String?
        let genre: [Int]?
        
        public init(id: String?, emotion: Int?, date: String?, title: String?, genre: [Int]?) {
            self.id = id
            self.emotion = emotion
            self.date = date
            self.title = title
            self.genre = genre
        }
    }
}
