//
//  StorageRequest.swift
//  Domain
//
//  Created by 정은희 on 2022/12/24.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

public struct StorageRequest {
    public let selectedFilter: Int
    
    public init(selectedFilter: Int) {
        self.selectedFilter = selectedFilter
    }
}
