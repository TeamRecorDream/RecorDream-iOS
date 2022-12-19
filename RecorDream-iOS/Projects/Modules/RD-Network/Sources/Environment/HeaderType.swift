//
//  HeaderType.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import RD_Core

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
    case refresh
}

enum HeaderContent: String {
    case json = "application/json"
    case multiPart = "multipart/form-data"
}
