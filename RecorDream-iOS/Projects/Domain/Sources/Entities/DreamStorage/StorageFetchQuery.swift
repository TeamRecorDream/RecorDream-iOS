//
//  StorageFetchQuery.swift
//  Domain
//
//  Created by 정은희 on 2022/12/27.
//  Copyright © 2022 RecorDream-iOS. All rights reserved.
//

public struct StorageFetchQuery {
    public var filterType: Int
    
    public init(filterType: Int) {
        self.filterType = filterType
    }
}
