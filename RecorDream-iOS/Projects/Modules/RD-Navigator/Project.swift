//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Junho Lee on 2022/09/18.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "RD-Navigator",
    product: .staticFramework,
    dependencies: [
        .project(target: "RD-Core", path: .relativeToRoot("Projects/Core/RD-Core"))
    ]
)
