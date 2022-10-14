//
//  RecordService.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Alamofire

public protocol RecordService {
    
}

public class DefaultRecordService: BaseService {
    public static let shared = DefaultRecordService()
    
    private override init() {}
}

extension DefaultRecordService: RecordService {
    
}

