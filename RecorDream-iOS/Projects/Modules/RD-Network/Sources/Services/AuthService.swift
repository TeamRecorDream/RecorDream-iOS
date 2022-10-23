//
//  AuthService.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Alamofire

public protocol AuthService {
    
}

public class DefaultAuthService: BaseService {
    public static let shared = DefaultAuthService()
    
    private override init() {}
}

extension DefaultAuthService: AuthService {
    
}
