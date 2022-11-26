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
    case uploadVoice(fileURL: URL)
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
    
    var multipart: MultipartFormData {
        switch self {
        case .uploadVoice(let url):
            let multiPart = MultipartFormData()
            
            guard let audioFile: Data = try? Data (contentsOf: url) else { return multiPart }
            multiPart.append(audioFile, withName: "audio", fileName: "audio.wav", mimeType: "audio/wav")
            
            return multiPart
        default: return MultipartFormData()
        }
    }
}

