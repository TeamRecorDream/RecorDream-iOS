//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Junho Lee on 2022/09/18.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "RD-Network",
    product: .staticFramework,
    dependencies: [
        .Project.RDCore
    ]
)
