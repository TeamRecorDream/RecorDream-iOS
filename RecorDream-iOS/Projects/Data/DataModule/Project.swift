//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Junho Lee on 2022/09/18.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "DataModule",
    product: .staticFramework,
    dependencies: [
        .project(target: "ThirdPartyLib", path: .relativeToRoot("Projects/Modules/ThirdPartyLib")),
        .project(target: "RD-Core", path: .relativeToRoot("Projects/Core/RD-Core"))
    ]
)
