//
//  DreamSearhControllable.swift
//  Presentation
//
//  Created by 정은희 on 2022/10/10.
//  Copyright © 2022 RecorDream. All rights reserved.
//

public enum DreamSearchResultType: Int, CaseIterable {
    case exist
    case non
    
    public static func type(_ index: Int) -> DreamSearchResultType {
        return self.allCases[index]
    }
}
