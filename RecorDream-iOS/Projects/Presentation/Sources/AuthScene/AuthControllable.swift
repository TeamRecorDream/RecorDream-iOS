//
//  AuthControllable.swift
//  Presentation
//
//  Created by 정은희 on 2022/12/01.
//  Copyright © 2022 RecorDream. All rights reserved.
//

protocol AuthControllable {
    func setupView()
    func setupConstraint()
}

enum AuthPlatformType: String {
    case kakao = "kakao"
    case apple = "apple"
}

enum TokenState {
    case valid
    case invalid
    case missed
}
