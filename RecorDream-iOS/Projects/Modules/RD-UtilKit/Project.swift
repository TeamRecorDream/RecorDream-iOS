//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Junho Lee on 2022/09/18.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "RD-UtilKit",
    product: .framework,
    dependencies: [
        .Project.RDUser,
        .Project.RDAnalytics
    ]
)
