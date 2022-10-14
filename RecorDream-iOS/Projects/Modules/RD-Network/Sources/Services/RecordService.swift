//
//  RecordService.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Alamofire

protocol RecordService {
    
}

class DefaultRecordService: BaseService {
    static let shared = DefaultRecordService()
    
    private override init() {}
}

extension DefaultRecordService: RecordService {
    
}

