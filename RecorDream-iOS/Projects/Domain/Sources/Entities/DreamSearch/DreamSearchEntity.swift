//
//  DreamSearchEntity.swift
//  DomainTests
//
//  Created by 정은희 on 2022/11/09.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

public struct Records: Equatable, Identifiable {
    public enum Genre: Int {
        case comedy
        case romance
        case action
        case thriller
        case mystery
        case fear
        case sf
        case fantasy
        case family
        case etc
        case none
    }
    
    public let id: String
    public let dreamColor: Int?
    public let emotion: Int?
    public let date: String?
    public let title: String?
    public let genre: Genre?
}

public struct DreamSearchEntity: Equatable {
    public let recordsCount: Int
    public let records: [Records]
}
