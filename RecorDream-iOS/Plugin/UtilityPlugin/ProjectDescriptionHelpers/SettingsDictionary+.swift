//
//  Dependency+SPM.swift
//  ProjectDescriptionHelpers
//
//  Created by Junho Lee on 2022/09/27.
//

import ProjectDescription

public extension SettingsDictionary {
    func setProductBundleIdentifier(_ value: String = "com.iOS$(BUNDLE_ID_SUFFIX)") -> SettingsDictionary {
        merging(["PRODUCT_BUNDLE_IDENTIFIER": SettingValue(stringLiteral: value)])
    }
    
    func setAssetcatalogCompilerAppIconName(_ value: String = "AppIcon$(BUNDLE_ID_SUFFIX)") -> SettingsDictionary {
        merging(["ASSETCATALOG_COMPILER_APPICON_NAME": SettingValue(stringLiteral: value)])
    }
    
    func setBuildActiveArchitectureOnly(_ value: Bool) -> SettingsDictionary {
        merging(["ONLY_ACTIVE_ARCH": SettingValue(stringLiteral: value ? "YES" : "NO")])
    }
    
    func setExcludedArchitectures(sdk: String = "iphonesimulator*", _ value: String = "arm64") -> SettingsDictionary {
        merging(["EXCLUDED_ARCHS[sdk=\(sdk)]": SettingValue(stringLiteral: value)])
    }
    
    func setSwiftActiveComplationConditions(_ value: String) -> SettingsDictionary {
        merging(["SWIFT_ACTIVE_COMPILATION_CONDITIONS": SettingValue(stringLiteral: value)])
    }
    
    func setAlwaysSearchUserPath(_ value: String = "NO") -> SettingsDictionary {
        merging(["ALWAYS_SEARCH_USER_PATHS": SettingValue(stringLiteral: value)])
    }
    
    func setStripDebugSymbolsDuringCopy(_ value: String = "NO") -> SettingsDictionary {
        merging(["COPY_PHASE_STRIP": SettingValue(stringLiteral: value)])
    }
    
    func setDynamicLibraryInstallNameBase(_ value: String = "@rpath") -> SettingsDictionary {
        merging(["DYLIB_INSTALL_NAME_BASE": SettingValue(stringLiteral: value)])
    }
    
    func setSkipInstall(_ value: Bool = false) -> SettingsDictionary {
        merging(["SKIP_INSTALL": SettingValue(stringLiteral: value ? "YES" : "NO")])
    }
    
    func setFirebaseDependency() -> SettingsDictionary {
        merging(["OTHER_LDFLAGS": ["-ObjC", "$(OTHER_LDFLAGS)"]])
    }
    
    func setCodeSignEntitlements() -> SettingsDictionary {
        merging(["CODE_SIGN_ENTITLEMENTS": SettingValue(stringLiteral: "RecorDream-iOS.entitlements")])
    }
    
    func setCodeSignManual() -> SettingsDictionary {
        merging(["CODE_SIGN_STYLE": SettingValue(stringLiteral: "Manual")])
            .merging(["DEVELOPMENT_TEAM": SettingValue(stringLiteral: "FY8N9XTH66")])
    }
    
    func setProvisioningDevelopment() -> SettingsDictionary {
        merging(["PROVISIONING_PROFILE_SPECIFIER": SettingValue(stringLiteral: "match Development com.RecorDream.Release")])
            .merging(["CODE_SIGN_IDENTITY": SettingValue(stringLiteral: "iPhone Developer")])
            .merging(["PROVISIONING_PROFILE": SettingValue(stringLiteral: "sign_com.RecorDream.Release_development")])
    }
    
    func setProvisioningAppstore() -> SettingsDictionary {
        merging(["PROVISIONING_PROFILE_SPECIFIER": SettingValue(stringLiteral: "match AppStore com.RecorDream.Release")])
            .merging(["CODE_SIGN_IDENTITY": SettingValue(stringLiteral: "iPhone Distribution")])
            .merging(["PROVISIONING_PROFILE": SettingValue(stringLiteral: "sign_com.RecorDream.Release_appstore")])
    }
}

