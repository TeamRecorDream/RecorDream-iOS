//
//  VoiceRouter.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import Alamofire

enum VoiceRouter {
    case uploadVoice(data: Data)
}

extension VoiceRouter: BaseRouter {
    var method: HTTPMethod {
        switch self {
        case .uploadVoice: return .post
        default: return .get
        }
    }
    
    var path: String {
        switch self {
        case .uploadVoice:
            return "/voice"
        default: return ""
        }
    }
    
    var parameters: RequestParams {
        switch self {
        default: return .requestPlain
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
    
    var multipart: MultipartFormData {
        switch self {
        case .uploadVoice(let data):
            let multiPart = MultipartFormData()
            multiPart.append(data, withName: "file", fileName: "audio.m4a", mimeType: "audio/m4a")
            return multiPart
        default: return MultipartFormData()
        }
    }
    
    func getDirectory() -> URL
        {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentDirectory = paths[0]
            return documentDirectory
        }
    
    var header: HeaderType {
        switch self {
        case .uploadVoice: return .tempForVoice
        default: return .withToken
        }
    }
}

