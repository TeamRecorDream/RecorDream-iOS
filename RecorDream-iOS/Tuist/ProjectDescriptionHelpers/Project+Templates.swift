import ProjectDescription
import UtilityPlugin

public extension Project {
    static func makeModule(
        name: String,
        platform: Platform = .iOS,
        product: Product,
        organizationName: String = "RecorDream",
        packages: [Package] = [],
        deploymentTarget: DeploymentTarget? = .iOS(targetVersion: "15.0", devices: [.iphone]),
        dependencies: [TargetDependency] = [],
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil,
        infoPlist: InfoPlist = .default
    ) -> Project {
        
        let defaultSettings: Settings = .settings(
            base: .init()
                .setFirebaseDependency()
                .setCodeSignManual()
                .setCodeSignEntitlements(),
            debug: .init()
                .setProvisioningDevelopment(),
            release: .init()
                .setProvisioningAppstore(),
            defaultSettings: .recommended)
        
        let thirdPartySettings: Settings = .settings(
            base: .init()
                .setCodeSignManual(),
            debug: .init()
                .setProvisioningDevelopment(),
            release: .init()
                .setProvisioningAppstore(),
            defaultSettings: .recommended)
        
        let settings = (name == "RecorDream-iOS") ? defaultSettings : thirdPartySettings
        
        let bundleId = (name == "RecorDream-iOS") ? "com.RecorDream.Release" : "\(organizationName).\(name)"

        let appTarget = Target(
            name: name,
            platform: platform,
            product: product,
            bundleId: bundleId,
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            dependencies: dependencies
        )

        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "\(organizationName).\(name)Tests",
            deploymentTarget: deploymentTarget,
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [.target(name: name)]
        )

        let schemes: [Scheme] = [.makeScheme(target: .debug, name: name)]

        let targets: [Target] = [appTarget, testTarget]

        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes
        )
    }
    
    static let baseinfoPlist: [String: InfoPlist.Value] = [
        "CFBundleShortVersionString": "1.0",
        "CFBundleVersion": "1",
        "CFBundleIdentifier": "com.RecorDream.Release",
        "UILaunchStoryboardName": "LaunchScreen",
        "CFBundleDisplayName": "레코드림",
        "LSApplicationQueriesSchemes": ["kakaokompassauth", "kakaolink"],
        "CFBundleURLTypes": ["CFBundleURLSchemes": ["kakao$(KAKAO_APP_KEY)"]],
        "UIApplicationSceneManifest": [
            "UIApplicationSupportsMultipleScenes": false,
            "UISceneConfigurations": [
                "UIWindowSceneSessionRoleApplication": [
                    [
                        "UISceneConfigurationName": "Default Configuration",
                        "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                    ],
                ]
            ]
        ],
        "UIStatusBarStyle": "UIStatusBarStyleLightContent",
        "UIViewControllerBasedStatusBarAppearance": false,
        "UIAppFonts": [
            "Item 0": "Pretendard-Black.otf",
            "Item 1": "Pretendard-Bold.otf",
            "Item 2": "Pretendard-ExtraBold.otf",
            "Item 3": "Pretendard-ExtraLight.otf",
            "Item 4": "Pretendard-Light.otf",
            "Item 5": "Pretendard-Medium.otf",
            "Item 6": "Pretendard-Regular.otf",
            "Item 7": "Pretendard-SemiBold.otf",
            "Item 8": "Pretendard-Thin.otf"
        ],
        "App Transport Security Settings": ["Allow Arbitrary Loads": true],
        "NSAppTransportSecurity": ["NSAllowsArbitraryLoads": true],
        "NSMicrophoneUsageDescription": "음성을 통해 꿈을 기록하기 위해서는 마이크 이용 권한이 필요합니다.",
        "Supports opening documents in place": true,
        "Application supports iTunes file sharing": true,
        "ITSAppUsesNonExemptEncryption": false,
        "UIBackgroundModes": ["fetch", "remote-notification"]
    ]
}

extension Scheme {
    static func makeScheme(target: ConfigurationName, name: String) -> Scheme {
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: target,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
            ),
            runAction: .runAction(configuration: target),
            archiveAction: .archiveAction(configuration: target),
            profileAction: .profileAction(configuration: target),
            analyzeAction: .analyzeAction(configuration: target)
        )
    }
}
