//
//  UserService.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Alamofire

public protocol UserService {
    
}

public class DefaultUserService: BaseService {
    public static let shared = DefaultUserService()
    
    private override init() {}
}

extension DefaultUserService: UserService {
    
}

