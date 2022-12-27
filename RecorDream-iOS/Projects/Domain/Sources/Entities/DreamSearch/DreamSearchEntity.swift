//
//  DreamSearchEntity.swift
//  DomainTests
//
//  Created by 정은희 on 2022/11/09.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

public struct DreamSearchEntity: Equatable {
    public let recordsCount: Int
    public let records: [Records]
    
    public init(recordsCount: Int, records: [Records]) {
        self.recordsCount = recordsCount
        self.records = records
    }
}

extension DreamSearchEntity {
    public struct Records: Equatable {
        public let id: String?
        public let emotion: Int?
        public let date: String?
        public let title: String?
        public let genre: [Int]?
        
        public init(id: String?, emotion: Int?, date: String?, title: String?, genre: [Int]?) {
            self.id = id
            self.emotion = emotion
            self.date = date
            self.title = title
            self.genre = genre
        }
    }
}
