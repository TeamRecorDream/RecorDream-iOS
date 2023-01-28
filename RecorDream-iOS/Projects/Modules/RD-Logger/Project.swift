//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Junho Lee on 2022/09/18.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "RD-Logger",
    product: .staticFramework,
    dependencies: [
        .Project.RDThridPartyLib,
        .SPM.FirebaseAnalytics,
        .SPM.FirebaseCrashlytics
    ]
)
