//
//  Dependency+Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Junho Lee on 2022/09/21.
//

import ProjectDescription

public extension TargetDependency {
    public struct Project {}
}

public extension TargetDependency.Project {
    static let RDNavigator = TargetDependency.project(target: "RD-Navigator", path: .relativeToRoot("Projects/Modules/RD-Navigator"))
    
    static let Presentation = TargetDependency.project(target: "Presentation", path: .relativeToRoot("Projects/Presentation"))
    
    static let RDCore = TargetDependency.project(target: "RD-Core", path: .relativeToRoot("Projects/Core"))
    
    static let Data = TargetDependency.project(target: "Data", path: .relativeToRoot("Projects/Data"))
    
    static let Domain = TargetDependency.project(target: "Domain", path: .relativeToRoot("Projects/Domain"))
    
    static let RDNetwork = TargetDependency.project(target: "RD-Network", path: .relativeToRoot("Projects/Modules/RD-Network"))
    static let RDDSKit = TargetDependency.project(target: "RD-DSKit", path: .relativeToRoot("Projects/Modules/RD-DSKit"))
    static let RDThridPartyLib = TargetDependency.project(target: "ThirdPartyLib", path: .relativeToRoot("Projects/Modules/ThirdPartyLib"))
    static let RDLogger = TargetDependency.project(target: "RD-Logger", path: .relativeToRoot("Projects/Modules/RD-Logger"))
}
