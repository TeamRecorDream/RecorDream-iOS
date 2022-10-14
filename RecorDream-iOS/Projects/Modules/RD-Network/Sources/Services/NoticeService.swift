//
//  NoticeService.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Alamofire

public protocol NoticeService {
    
}

public class DefaultNoticeService: BaseService {
    public static let shared = DefaultNoticeService()
    
    private override init() {}
}

extension DefaultNoticeService: NoticeService {
    
}

