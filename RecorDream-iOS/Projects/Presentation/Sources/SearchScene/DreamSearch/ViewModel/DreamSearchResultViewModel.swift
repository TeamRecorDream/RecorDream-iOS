//
//  DreamSearchResultViewModel.swift
//  Presentation
//
//  Created by 정은희 on 2022/10/10.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import Domain
import RD_Network

struct DreamSearchResultViewModel {
    // Input
    var dreamSearchResult: DreamSearchResult!
    // Output
    var recordsCount: Int = 0
    var hasRecords: [Records] = []
    
    init(dreamSearchResultModel: DreamSearchResult) {
        self.dreamSearchResult = dreamSearchResultModel
        self.configureOutputForCell()
    }
}

extension DreamSearchResultViewModel {
    mutating func configureOutputForCell() {
        self.recordsCount = self.getRecordsCount()
        self.hasRecords = self.getRecords()
    }
}

extension DreamSearchResultViewModel {
    private func getRecordsCount() -> Int {
        return dreamSearchResult.recordsCount
    }
    private func getRecords() -> [Records] {
        return dreamSearchResult.records
    }
}
