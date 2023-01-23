// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "TMDiscover",
            targets: ["TMDiscover"]),
    ],
    dependencies: [
        .package(path: "../Common"),
        .package(url: "https://github.com/SwiftGen/SwiftGenPlugin", from: "6.6.0"),
        .package(url: "https://github.com/Quick/Nimble", from: "11.2.1"),
        .package(url: "https://github.com/Quick/Quick", from: "6.1.0")
    ],
    targets: [
        .target(
            name: "TMDiscover",
            dependencies: ["TMModuleCommon", .common("TMCore"), .common("TMUI"), .common("TMAPI")],
            plugins: [.swiftGenPlugin]),
        
        .target(
            name: "TMModuleCommon",
            dependencies: [.common("TMAPI"), .common("TMUI"), .common("TMResources")]),
        
        // Tests
        
        .testTarget(
            name: "TMDiscoverTests",
            dependencies: ["TMDiscover", "Nimble", "Quick"]
        )
    ]
)

private extension Target.Dependency {
    static func common(_ name: String) -> Self {
        .product(name: name, package: "Common")
    }
}

fileprivate extension Target.PluginUsage {
    static let swiftGenPlugin = Self.plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin")
}
