//
//  VoiceService.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Alamofire

protocol VoiceService {
    
}

class DefaultVoiceService: BaseService {
    static let shared = DefaultVoiceService()
    
    private override init() {}
}

extension DefaultVocieService: VoiceService {
    
}

