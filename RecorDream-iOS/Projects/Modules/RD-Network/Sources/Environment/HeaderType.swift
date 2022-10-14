//
//  HeaderType.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

enum HeaderType {
    case `default`
    case withToken
    case multiPart
    case multiPartWithToken
    case reissuance
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case accesstoken = "token"
    case refreshtoken = "refreshtoken"
}

enum HeaderContent: String {
    case json = "application/json"
    case multiPart = "multipart/form-data"
    case accessTokenSerial = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyZDRlODRmMGZmMmY5MDBlYTg4YmVjMyIsImlhdCI6MTY1ODMyNTUwOCwiZXhwIjoxNjU4NTg0NzA4fQ.ND6-ZIthGE4LRjYtZnWyqc0pJluiUYO_Vb_9gkmETLw"
    case refreshTokenSerial = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyZDRlODRmMGZmMmY5MDBlYTg4YmVjMyIsImlhdCI6MTY1ODMyNTUwOCwiZXhwIjoxNjU4NTg0NzA4fQ.ND6-ZIthGE4LRjYtZnWyqc0pJluiUYO_Vb_9gkmETLw"
}
