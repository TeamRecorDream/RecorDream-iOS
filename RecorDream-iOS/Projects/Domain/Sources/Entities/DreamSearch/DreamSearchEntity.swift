//
//  DreamSearchEntity.swift
//  DomainTests
//
//  Created by 정은희 on 2022/11/09.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

public struct Records: Codable {
    public let id: String
    public let dreamColor: Int?
    public let emotion: Int?
    public let date: String?
    public let title: String?
    public let genre: [Int]?
}

public struct DreamSearchEntity: Codable {
    public let recordsCount: Int
    public let records: [Records]
}
