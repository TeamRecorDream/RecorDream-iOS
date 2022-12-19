//
//  AuthRepository.swift
//  Domain
//
//  Created by 정은희 on 2022/12/04.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import RxSwift

public protocol AuthRepository {
    func requestAuth(request: AuthRequest) -> Observable<AuthEntity?>
}
