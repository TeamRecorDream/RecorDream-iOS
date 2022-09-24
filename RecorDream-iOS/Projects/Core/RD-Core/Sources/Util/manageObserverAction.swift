//
//  manageObserverAction.swift
//
//  Created by Junho Lee on 2022/09/24.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

extension NSObject {
  func postObserverAction(_ keyName: BaseNotiList, object: Any? = nil) {
    NotificationCenter.default.post(name: BaseNotiList.makeNotiName(list: keyName), object: object)
  }
  
  func addObserverAction(_ keyName: BaseNotiList, action : @escaping (Notification) -> Void) {
    NotificationCenter.default.addObserver(forName: BaseNotiList.makeNotiName(list: keyName),
                                           object: nil,
                                           queue: nil,
                                           using: action)
  }
  
  func removeObserverAction(_ keyName: BaseNotiList) {
    NotificationCenter.default.removeObserver(self, name: BaseNotiList.makeNotiName(list: keyName), object: nil)
  }
}
