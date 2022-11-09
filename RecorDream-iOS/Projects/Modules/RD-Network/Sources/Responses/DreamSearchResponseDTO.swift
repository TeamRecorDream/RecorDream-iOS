//
//  DreamSearchResponseDTO.swift
//  RD-Network
//
//  Created by 정은희 on 2022/11/08.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

struct DreamSearchResponseDTO: Decodable {
    let query: String
    let results: [DreamSearchResultDTO]
}

extension DreamSearchResponseDTO {
    struct DreamSearchResultDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case recordsCount = "records_count"
            case records
        }
        
        let recordsCount: Int
        let records: [Records]
    }
    
    struct Records: Decodable {
        private enum CodingKeys: String, CodingKey {
            case id = "_id"
            case dreamColor = "dream_color"
            case emotion, date, title, genre
        }
        enum GenreDTO: Int, Decodable {
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
        
        let id: String?
        let dreamColor: Int?
        let emotion: Int?
        let date: String?
        let title: String?
        let genre: GenreDTO?
    }
}
