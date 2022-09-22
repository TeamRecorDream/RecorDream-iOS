//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Junho Lee on 2022/09/18.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.makeModule(
    name: "RD-Core",
    product: .staticFramework,
    dependencies: [
        .Project.RDThridPartyLib,
    ]
)
