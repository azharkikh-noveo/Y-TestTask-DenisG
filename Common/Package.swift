// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// MARK: - Package

let package = Package(
    name: "Common",
    defaultLocalization: "en",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "TMCore",
            targets: ["TMCore"]),
        
        .library(
            name: "TMUI",
            targets: ["TMUI"]),
        
        .library(
            name: "TMAPI",
            targets: ["TMAPI"]),

        .library(
            name: "TMLaunch",
            targets: ["TMLaunch"]),

        .library(
            name: "TMResources",
            targets: ["TMResources"])
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMinor(from: "15.0.0")),
        .package(url: "https://github.com/SwiftGen/SwiftGenPlugin", from: "6.6.0"),
        .package(url: "https://github.com/kean/Nuke", from: "11.5.3"),
        .package(url: "https://github.com/SwiftKickMobile/SwiftMessages", from: "9.0.6"),
        .package(url: "https://github.com/Quick/Nimble", from: "11.2.1"),
        .package(url: "https://github.com/Quick/Quick", from: "6.1.0")
    ],
    targets: [
        .target(
            name: "TMResources",
            dependencies: [],
            plugins: [.swiftGenPlugin]),
        
        .target(
            name: "TMCore",
            dependencies: ["TMResources"]),
        
        .target(
            name: "TMUI",
            dependencies: ["SwiftMessages", "TMCore", "TMResources", "Nuke"],
            plugins: [.swiftGenPlugin]),
        
        .target(
            name: "TMAPI",
            dependencies: ["TMCore", "Moya"]),

        .target(
            name: "TMLaunch",
            dependencies: ["TMCore", "TMUI", "TMAPI"]),
        
        // Tests
    
        .testTarget(
            name: "TMCoreTests",
            dependencies: ["TMCore", "Nimble", "Quick"])
    ]
)

// MARK: - Plugins

fileprivate extension Target.PluginUsage {

    static let swiftGenPlugin = Self.plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin")
}
