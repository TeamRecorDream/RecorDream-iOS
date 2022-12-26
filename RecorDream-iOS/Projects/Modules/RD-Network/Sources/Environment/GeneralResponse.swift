//
//  GeneralResponse.swift
//  RD-NetworkTests
//
//  Created by Junho Lee on 2022/10/14.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

public struct GeneralResponse<T> {
    public let success: Bool
    public let status: Int
    public let message: String?
    public let data: T?
    
    enum CodingKeys: String, CodingKey {
        case success
        case status
        case message
        case data
    }
}

extension GeneralResponse: Decodable where T: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        success = try container.decode(Bool.self, forKey: .success)
        status = try container.decode(Int.self, forKey: .status)
        message = try? container.decode(String.self, forKey: .message)
        data = try? container.decode(T.self, forKey: .data)
    }
}
