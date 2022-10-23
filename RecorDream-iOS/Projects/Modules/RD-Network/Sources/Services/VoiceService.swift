//
//  VoiceService.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Alamofire

public protocol VoiceService {
    
}

public class DefaultVoiceService: BaseService {
    public static let shared = DefaultVoiceService()
    
    private override init() {}
}

extension DefaultVoiceService: VoiceService {
    
}

