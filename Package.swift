// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BehindMetal",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .watchOS(.v8),
        .tvOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "BehindMetal",
            targets: ["BehindMetal"]),
    ],
    dependencies: [
        .package(url: "https://github.com/victorabroum/BehindECS", branch: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "BehindMetal", dependencies: [
            .product(name: "BehindECS", package: "BehindECS")
        ]),
        
    ]
)
