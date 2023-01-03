//
//  DreamStorageEntity.swift
//  Domain
//
//  Created by 정은희 on 2022/12/27.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

import Foundation

public struct DreamStorageEntity: Hashable {
    public let filterList: [FilterList]
    public let recordList: RecordList
    
    public init(filterList: [FilterList], recordList: RecordList) {
        self.filterList = filterList
        self.recordList = recordList
    }
    
    public func toRequest() -> StorageFetchQuery {
        guard let filterIndex = self.filterList.firstIndex(where: { $0.isSelected }) else { return .init(filterType: 0) }
        
        return StorageFetchQuery.init(filterType: filterIndex)
    }
}

extension DreamStorageEntity {
    public struct FilterList: Hashable {
        let id = UUID()
        public let isSelected: Bool
        
        public init(isSelected: Bool) {
            self.isSelected = isSelected
        }
    }
}

extension DreamStorageEntity {
    public struct RecordList: Hashable {
        let id = UUID()
        public let recordsCount: Int
        public let records: [Record]
        
        public init(recordsCount: Int, records: [Record]) {
            self.recordsCount = recordsCount
            self.records = records
        }
    }
}

extension DreamStorageEntity.RecordList {
    public struct Record: Hashable {
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
