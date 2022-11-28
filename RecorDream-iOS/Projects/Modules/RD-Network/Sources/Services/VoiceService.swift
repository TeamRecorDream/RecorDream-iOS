//
//  VoiceService.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import Alamofire
import RxSwift

public protocol VoiceService {
    func uploadVoice(data: Data) -> Observable<DreamWriteVoiceResponse?>
}

public class DefaultVoiceService: BaseService {
    public static let shared = DefaultVoiceService()
    
    private override init() {}
}

extension DefaultVoiceService: VoiceService {
    public func uploadVoice(data: Data) -> RxSwift.Observable<DreamWriteVoiceResponse?> {
        uploadMultipartInRx(VoiceRouter.uploadVoice(data: data))
    }
}
