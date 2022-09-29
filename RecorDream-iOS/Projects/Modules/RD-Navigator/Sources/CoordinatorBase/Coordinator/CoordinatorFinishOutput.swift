//
//  CoordinatorFinishOut.swift
//  RouterCoordinator
//
//  Created by Junho Lee on 2022/09/29.
//

import Foundation

/// Coordinator가 자신의 플로우를 마쳤을 때 호출됩니다. 대개의 경우 removeDependency()가 호출됩니다.
protocol CoordinatorFinishOutput {
    var finishFlow: (() -> Void)? { get set }
}

typealias DefaultCoordinator = BaseCoordinator & CoordinatorFinishOutput
