//
//  MyPageDTO.swift
//  PresentationTests
//
//  Created by Junho Lee on 2022/10/09.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Domain
import RD_Network

import Foundation

extension DreamWriteResponse {
    func toDomain() -> DreamWriteEntity {
        return .init(userId: self.userId)
    }
}
