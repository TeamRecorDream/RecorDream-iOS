//
//  DreamWriteDTO.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

public struct DreamWriteResponse: Codable {
    public let userId: Int
    public let content: String
}
