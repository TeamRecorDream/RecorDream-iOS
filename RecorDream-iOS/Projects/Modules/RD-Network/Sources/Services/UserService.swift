//
//  UserService.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Alamofire

protocol UserService {
    
}

class DefaultUserService: BaseService {
    static let shared = DefaultUserService()
    
    private override init() {}
}

extension DefaultUserService: UserService {
    
}

