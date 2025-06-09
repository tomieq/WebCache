// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WebCache",
    dependencies: [
        .package(url: "https://github.com/tomieq/SwiftExtensions", branch: "master"),
        .package(url: "https://github.com/tomieq/Logger", exact: "1.0.2"),
        .package(url: "https://github.com/tomieq/swifter", from: "3.1.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "WebCache",
            dependencies: [
                .product(name: "SwiftExtensions", package: "SwiftExtensions"),
                .product(name: "Logger", package: "Logger"),
                .product(name: "Swifter", package: "Swifter")
            ]),
    ]
)
