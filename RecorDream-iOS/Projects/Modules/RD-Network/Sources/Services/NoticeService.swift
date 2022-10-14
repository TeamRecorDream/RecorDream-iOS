//
//  NoticeService.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Alamofire

protocol NoticeService {
    
}

class DefaultNoticeService: BaseService {
    static let shared = DefaultNoticeService()
    
    private override init() {}
}

extension DefaultNoticeService: NoticeService {
    
}

