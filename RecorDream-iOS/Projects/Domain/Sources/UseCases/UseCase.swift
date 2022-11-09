//
//  UseCase.swift
//  DomainTests
//
//  Created by 정은희 on 2022/11/09.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import RD_Core

public protocol UseCase {
    @discardableResult
    func start() -> Cancellable?
}
