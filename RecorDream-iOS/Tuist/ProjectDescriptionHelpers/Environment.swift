import ProjectDescription

public enum Environment {
    public static let appBundleId = "com.RecorDream.Release"
    public static let organizationName = "RecorDream-iOS"
    public static let deploymentTarget: DeploymentTarget = .iOS(targetVersion: "15.0", devices: [.iphone])
}
