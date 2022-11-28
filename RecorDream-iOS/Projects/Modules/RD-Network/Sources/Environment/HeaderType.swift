//
//  HeaderType.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

public enum HeaderType {
    case `default`
    case withToken
    case multiPart
    case multiPartWithToken
    case reissuance
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case authorization = "Authorization"
    
    case access
    case refresh = "refreshtoken"
}

enum HeaderContent: String {
    case json = "application/json"
    case multiPart = "multipart/form-data"
    case accessTokenSerial = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjM1Yjk3N2VhNWZkZDU3YzdlYmI0YzdkIn0sImlhdCI6MTY2OTQ2OTkwMiwiZXhwIjoxNjcxODAyNzAyfQ._y1ec4x0PIPkXp9Gs19XFGNMEtTdDqRIZ-Z3XMdWUjo"
    case refreshTokenSerial = "리프레시 토큰 스트링"
}
